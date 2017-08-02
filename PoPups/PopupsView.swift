//
//  PopupsView.swift
//  PopupViews
//
//  Created by 黄穆斌 on 2017/6/26.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

class PopupsView: UIView {
    
    // MARK: - Datas
    
    /** Display time, defalut is 3. */
    var run_duration: TimeInterval = 3
    /** Dismiss time interval since 1970. Default set in display function. */
    private var run_time: TimeInterval = 0
    
    // MARK: Override Data
    
    override var frame: CGRect {
        didSet {
            if frame.size != oldValue.size {
                update_center_layout()
            }
        }
    }
    
    override var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                update_center_layout()
            }
        }
    }
    
    // MARK: - Content Views
    
    /** Content view. */
    var content_view: UIView = UIView()
    /** Content cancel botton. */
    var content_button: UIButton = UIButton(type: UIButtonType.system)
    /** */
    var content_button_offset = CGPoint.zero
    
    // MARK: - Init
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func deploy() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        // Notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation),
            name: .UIApplicationDidChangeStatusBarOrientation,
            object: nil
        )
        
        // Deploy
        deploy_at_init()
        update_content_layout()
        run_timer()
    }
    
    /** Deploy action at init. */
    func deploy_at_init() {
        // Timer
        self.run_time = (self.run_duration == 0 ? 1000000 : self.run_duration) + Date().timeIntervalSince1970
        
        // Content View
        addSubview(content_view)
        content_view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        content_view.layer.cornerRadius = 20
        content_view.layer.shadowRadius = 2
        content_view.layer.shadowOffset = CGSize.zero
        content_view.layer.shadowOpacity = 1
        
        // Content Button
        addSubview(content_button)
        content_button.setImage(PopupsView.ImageCache.cross, for: .normal)
        content_button.tintColor = UIColor.white
        content_button.layer.shadowOpacity = 1
        content_button.layer.shadowOffset = CGSize.zero
        content_button.sizeToFit()
        content_button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    // MARK: Orientation
    
    /** Orientaion notification action. */
    func orientation() {
        DispatchQueue.main.async { [weak self] in
            if let view = self?.superview {
                UIView.animate(withDuration: 0.25, animations: {
                    self?.frame = view.bounds
                    self?.update_center_layout()
                })
            }
        }
    }
    
    // MARK: - Display and Dismiss
    
    /** Display popups view to view. */
    func display(to: UIView) {
        // Clock old.
        for subview in to.subviews {
            if subview is PopupsView {
                subview.removeFromSuperview()
                break
            }
        }
        
        // Deploy and append to superview.
        self.frame = to.bounds
        self.alpha = 0
        self.update_content_layout()
        to.addSubview(self)
        if let scroll = to as? UIScrollView {
            scroll.isScrollEnabled = false
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }, completion: { _ in
            self.display_completion()
        })
    }
    
    /** dismiss from superview */
    func dismiss() {
        dismiss_action?()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: { _ in
            if let scroll = self.superview as? UIScrollView {
                scroll.isScrollEnabled = true
            }
            self.removeFromSuperview()
        })
    }
    
    // MARK: - Timer
    
    /** source timer */
    fileprivate var life_timer: DispatchSourceTimer?
    func run_timer() {
        life_timer = DispatchSource.makeTimerSource(
            flags: DispatchSource.TimerFlags(rawValue: 1),
            queue: DispatchQueue.main
        )
        life_timer?.scheduleRepeating(
            wallDeadline: DispatchWallTime.now(),
            interval: DispatchTimeInterval.milliseconds(200)
        )
        life_timer?.setEventHandler(handler: { [weak self] in
            if Date().timeIntervalSince1970 > (self?.run_time ?? 0) {
                self?.dismiss()
            }
        })
        life_timer?.resume()
    }
    
    // MARK: - Subview override.
    
    /** Call when the frame is changed. */
    func update_center_layout() {
        content_view.center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height / 2
        )
        
        content_button.center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height - 60
        )
    }
    /** Call when init. */
    func update_content_layout() { }
    
    /** Call when display. */
    func display_completion() { }
    
    /** Update datas */
    func update(data: Any) { }
    
    /** Call when dismiss */
    var dismiss_action: (() -> Void)?
}
