//
//  PopupsView.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/24.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

/** A popups view control. */
class PopupsView: UIView {

    /** Popup views */
    var units: [PopupsView.Unit] = []
    
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
        print("Popos View is deinit;")
    }
    
    /** Deploy action */
    private func deploy() {
        print("Popos View is init;")
        //self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
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
                    self?.layout_units_center(bounds: view.bounds)
                })
            }
        }
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
                if let view = self {
                    var i = 0
                    while i < view.units.count {
                        if view.units[i].dismiss_time < time {
                            let unit = view.units.remove(at: i)
                            view.dismiss(unit: unit)
                        }
                        else {
                            i += 1
                        }
                    }
                }
            }
        })
        life_timer?.resume()
    }
    
    // MARK: - Display and dismiss
    
    /** Add unit to Popups view */
    func display(unit: PopupsView.Unit) {
        unit.dismiss_time = unit.display_duration + Date().timeIntervalSince1970
        unit.content_reconfigure()
        layout_new_center(unit: unit)
        self.units.append(unit)
        unit.alpha = 0
        addSubview(unit)
        UIView.animate(withDuration: 0.25, animations: {
            if unit is CenterUnit {
                self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.superview?.isUserInteractionEnabled = false
            }
            unit.alpha = 1
        }, completion: { _ in
            self.layout_units_center(bounds: self.bounds)
        })
    }
    
    /** Dismiss and remove unit. */
    func dismiss(unit: PopupsView.Unit) {
        UIView.animate(withDuration: 0.25, animations: {
            unit.alpha = 0
        }, completion: { _ in
            unit.removeFromSuperview()
            self.layout_units_center(bounds: self.bounds)
        })
        if unit is CenterUnit {
            for unit in self.units {
                if unit is CenterUnit {
                    return
                }
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundColor = UIColor.clear
                self.superview?.isUserInteractionEnabled = true
            })
        }
    }
    
    // MARK: - Layout
    
    /** Update total units's center. */
    func layout_units_center(bounds: CGRect) {
        var center_units: [PopupsView.CenterUnit] = []
        var bottom_units: [PopupsView.BottomUnit] = []
        var center_height: CGFloat = 0
        var bottom_height: CGFloat = 0
        
        for unit in units {
            if let center = unit as? PopupsView.CenterUnit {
                center_units.append(center)
                center_height += center.content_size().height
            }
            else if let bottom = unit as? PopupsView.BottomUnit {
                bottom_units.append(bottom)
                bottom_height += bottom.content_size().height
            }
        }
        
        center_height += CGFloat(center_units.count - 1) * 10
        bottom_height += CGFloat(bottom_units.count - 1) * 10 + 10
        
        let center_x = bounds.width / 2
        
        var center_y = (bounds.height - center_height) / 2
        for unit in center_units {
            let height = unit.content_size().height
            UIView.animate(withDuration: 0.25, animations: {
                unit.center = CGPoint(
                    x: center_x,
                    y: center_y + height / 2
                )
            })
            center_y += height + 10
        }
        
        center_y = (bounds.height - bottom_height)
        for unit in bottom_units {
            let height = unit.content_size().height
            UIView.animate(withDuration: 0.25, animations: {
                unit.center = CGPoint(
                    x: center_x,
                    y: center_y + height / 2
                )
            })
            center_y += height + 10
        }
    }
    
    /** Count the new center y in last. */
    func layout_new_center(unit: PopupsView.Unit) {
        if let _ = unit as? PopupsView.BottomUnit {
            unit.center = CGPoint(
                x: self.bounds.width / 2,
                y: self.bounds.height + unit.bounds.height / 2
            )
        }
        else {
            var max_y: CGFloat = 0
            for unit in units {
                if let center = unit as? PopupsView.CenterUnit {
                    max_y = max(max_y, center.frame.maxY)
                }
            }
            unit.center = CGPoint(
                x: self.bounds.width / 2,
                y: max_y == 0 ? bounds.height / 2 : max_y + unit.bounds.height / 2 + 10
            )
        }
    }
    
}


// MARK: - Class Action

extension PopupsView {
    
    /** Display the unit to view. */
    class func display(unit: PopupsView.Unit, to view: UIView) {
        // Already Has
        for subView in view.subviews {
            if let popups = subView as? PopupsView {
                popups.display(unit: unit)
                return
            }
        }
        
        // Create new popups view
        let popups = PopupsView()
        popups.frame = view.bounds
        popups.alpha = 0
        view.addSubview(popups)
        UIView.animate(withDuration: 0.25, animations: {
            popups.alpha = 1
        }, completion: { _ in
            popups.display(unit: unit)
            popups.run_timer()
        })
    }
    
    /** Get the popups view */
    class func hint_view(in view: UIView) -> PopupsView? {
        for subView in view.subviews {
            if let popups = subView as? PopupsView {
                return popups
            }
        }
        return nil
    }
    
}
