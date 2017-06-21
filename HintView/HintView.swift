//
//  HintView.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

// MARK: - Hint View

/**
 */
class HintView: UIView {
    
    // MARK: Init
    
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
        print("Dismiss")
    }
    
    private func deploy() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientation),
            name: .UIApplicationDidChangeStatusBarOrientation,
            object: nil
        )
    }
    
    // MARK: Orientation
    
    func orientation() {
        DispatchQueue.main.async { [weak self] in
            if let view = self?.superview {
                UIView.animate(withDuration: 0.25, animations: {
                    self?.frame = view.bounds
                    self?.update_units_center(bounds: view.bounds)
                })
            }
        }
    }
    
    // MARK: - Data
    
    /** Units */
    var units: [HintUnit] = []
    
    // MARK: - Timer
    
    fileprivate var timer: DispatchSourceTimer?
    fileprivate func run_timer() {
        timer = DispatchSource.makeTimerSource(
            flags: DispatchSource.TimerFlags(rawValue: 1),
            queue: DispatchQueue.main
        )
        timer?.scheduleRepeating(
            wallDeadline: DispatchWallTime.now(),
            interval: DispatchTimeInterval.milliseconds(200)
        )
        timer?.setEventHandler(handler: { [weak self] in
            if self?.units.isEmpty == true {
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self?.alpha = 0
                }, completion: { _ in
                    self?.removeFromSuperview()
                })
            }
            else {
                let time = Date().timeIntervalSince1970
                if let hint = self {
                    var i = 0
                    while i < hint.units.count {
                        if hint.units[i].dismiss_time < time {
                            let unit = hint.units.remove(at: i)
                            hint.dismiss(unit: unit)
                        }
                        else {
                            i += 1
                        }
                    }
                }
            }
        })
        timer?.resume()
    }
    
}

// MARK: - Actions

extension HintView {
    
    /** Display action */
    class func display(to: UIView, unit: HintUnit) {
        for subview in to.subviews {
            if let hint = subview as? HintView {
                hint.display(unit: unit)
                return
            }
        }
        
        let hint = HintView()
        hint.frame = to.bounds
        hint.alpha = 0
        to.addSubview(hint)
        UIView.animate(
            withDuration: 0.25,
            animations: {
                hint.alpha = 1
        }, completion: { _ in
            hint.display(unit: unit)
            hint.run_timer()
        })
    }
    
    
    /** display */
    func display(unit: HintUnit) {
        unit.update_dismiss_time()
        unit.update_size()
        unit.center = CGPoint(
            x: bounds.width / 2,
            y: new_center_y(height: unit.bounds.height)
        )
        
        //unit.backgroundColor = UIColor.red
        units.append(unit)
        unit.alpha = 0
        addSubview(unit)
        UIView.animate(withDuration: 0.25, animations: {
            unit.alpha = 1
        }, completion: { _ in
            unit.start()
        })
        
        update_units_center(bounds: self.bounds)
    }
    
    /** Dismiss hint unit to hint view. */
    func dismiss(unit: HintUnit) {
        UIView.animate(
            withDuration: 0.25,
            animations: {
                unit.alpha = 0
        }, completion: { _ in
            unit.removeFromSuperview()
            self.update_units_center(bounds: self.bounds)
        })
    }
    
}

// MARK: - Size

extension HintView {
    
    /** 更新 Units 的位置 */
    func update_units_center(bounds: CGRect) {
        var height: CGFloat = 0
        for unit in self.units {
            height += unit.bounds.height
        }
        height = height + CGFloat(self.units.count - 1) * 10
        
        let center_x = bounds.width / 2
        var center_y = (bounds.height - height) / 2
        
        for unit in self.units {
            UIView.animate(withDuration: 0.25, animations: {
                unit.center = CGPoint(
                    x: center_x,
                    y: center_y + unit.bounds.height / 2
                )
            })
            center_y += unit.bounds.height + 10
        }
    }
    
    /** 获取最新加入的 unit 的 center y */
    func new_center_y(height: CGFloat) -> CGFloat {
        if let last = self.units.last {
            return last.frame.maxY + 10 + height / 2
        }
        else {
            return self.bounds.height / 2
        }
    }
    
}


// MARK: - Hint View Unit

extension HintView {
    
    /**
     Hint Info Unit.
     */
    class HintUnit: UIView {
        
        // MARK: Data
        
        /** 存在时间 */
        var duration_time: TimeInterval = 3
        /** 消失时间 */
        var dismiss_time: TimeInterval = 0
        
        /** update dismiss time */
        func update_dismiss_time() {
            dismiss_time = Date().timeIntervalSince1970 + duration_time
        }
        
        /** id */
        var identifier: String?
        
        // MARK: Init
        
        init() {
            super.init(frame: CGRect.zero)
            deploy_at_init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            deploy_at_init()
        }
        
        // MARK: Sub View to Override
        
        /** Deploy at init */
        func deploy_at_init() { }
        /** Update Size */
        func update_size() {
            //self.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        /** Update Data */
        func update(data: Any) { }
        
        func start() { }
        
        deinit {
            print("Hint Unit \(self) is deinit.")
        }
        
    }
    
    
}
