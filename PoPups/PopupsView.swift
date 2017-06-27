//
//  PopupsView.swift
//  PopupViews
//
//  Created by 黄穆斌 on 2017/6/26.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

class PopupsView: UIView {

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
        print("Popos View is deinit;")
    }
    
    /** Deploy action */
    private func deploy() {
        print("Popos View is init;")
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation),
            name: .UIApplicationDidChangeStatusBarOrientation,
            object: nil
        )
    }
    
    // MARK: Orientation
    
    /** Orientaion notification action. */
    func orientation() {
        DispatchQueue.main.async { [weak self] in
            if let view = self?.superview {
                UIView.animate(withDuration: 0.25, animations: {
                    self?.frame = view.bounds
                })
            }
        }
    }
    
    // MARK: - Data
    
    /** display duration time */
    @IBInspectable var display_duration: TimeInterval = 3
    /**  */
    @IBInspectable var dismiss_time: TimeInterval = 0
    
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
            let time = Date().timeIntervalSince1970
            if time > (self?.dismiss_time ?? 0) {
                self?.dismiss()
            }
        })
        life_timer?.resume()
    }
    
    // MARK: - Display and dismiss.
    
    func display(to: UIView) {
        
    }
    
    func dismiss() {
        
    }
}
