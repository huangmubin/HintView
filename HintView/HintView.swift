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
 Hint View Kit.
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
        print("Hint View \(self) is deinit. Units is \(units.count);")
    }
    
    /** Deploy action */
    private func deploy() {
        print("Hint View \(self) is init!")
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
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
                    self?.update_units_center(bounds: view.bounds)
                })
            }
        }
    }
    
    // MARK: - Datas
    
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
                UIView.animate(withDuration: 0.25, animations: {
                    self?.alpha = 0
                }, completion: { _ in
                    self?.superview?.isUserInteractionEnabled = true
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

// MARK: - Class Action - Display Unit

extension HintView {
    
    /** Display the unit to view. */
    class func display(unit: HintUnit, to view: UIView) {
        // Already Has
        for subView in view.subviews {
            if let hint = subView as? HintView {
                hint.add(unit: unit)
                return
            }
        }
        
        // Create new hint view
        view.isUserInteractionEnabled = false
        let hint = HintView()
        hint.frame = view.bounds
        hint.alpha = 0
        view.addSubview(hint)
        UIView.animate(withDuration: 0.25, animations: {
                hint.alpha = 1
        }, completion: { _ in
            hint.add(unit: unit)
            hint.run_timer()
        })
    }
    
    /** Get the hint view */
    class func hint_view(in view: UIView) -> HintView? {
        for subView in view.subviews {
            if let hint = subView as? HintView {
                return hint
            }
        }
        return nil
    }
    
}

// MAKR: - Actions - Display and Dismiss

extension HintView {
    
    /** Add unit to hint view */
    func add(unit: HintUnit) {
        // Deploy Unit
        unit.update_times()
        unit.init_update_bounds()
        unit.center = CGPoint(
            x: bounds.width / 2,
            y: new_center_y(height: unit.bounds.height)
        )
        
        // Show unit
        units.append(unit)
        unit.alpha = 0
        addSubview(unit)
        UIView.animate(withDuration: 0.25, animations: {
            unit.alpha = 1
        }, completion: { _ in
            unit.init_start_animation()
        })
        
        // Update Layout
        self.update_units_center(bounds: self.bounds)
    }
    
    /** Dismiss and remove unit. */
    func dismiss(unit: HintUnit) {
        UIView.animate(withDuration: 0.25, animations: {
            unit.alpha = 0
        }, completion: { _ in
            unit.removeFromSuperview()
            self.update_units_center(bounds: self.bounds)
        })
    }
    
}

// MARK: - Units Action

extension HintView {
    
    func unit(identifier: String?) -> HintUnit? {
        for unit in units {
            if unit.identifier == identifier {
                return unit
            }
        }
        return nil
    }
    
    func unit(unit: HintUnit, to_result: Any) {
        let rect = unit.result_deploy(type: to_result)
        
    }
    
}

// MARK: - Size

extension HintView {
    
    /** Update total units's center. */
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
    
    /** Count the new center y in last. */
    func new_center_y(height: CGFloat) -> CGFloat {
        if let last = self.units.last {
            return last.frame.maxY + 10 + height / 2
        }
        else {
            return self.bounds.height / 2
        }
    }
    
}
