//
//  HintView_HintUnit.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/23.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

extension HintView {
    
    /** Hint's base unit. Control in hint view. */
    class HintUnit: UIView {
        
        // MARK: - Identifier
        
        /** Hint's identifier */
        var identifier: String?
        
        // MARK: - Time
        
        /** Hint unit display duration time, default is 3. */
        var duration_time: TimeInterval = 3
        /** Hint unit dismiss time interval since 1970. */
        var dismiss_time: TimeInterval = 0
        
        /** Update the duration time and dismiss time. */
        func update_times(duration: TimeInterval? = nil) {
            if let time = duration {
                duration_time = time
            }
            
            dismiss_time = Date().timeIntervalSince1970 + duration_time
        }
        
        // MARK: - Init
        
        init() {
            super.init(frame: CGRect.zero)
            deploy_at_init()
            print("Hint View Unit \(self) is init!")
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            deploy_at_init()
            print("Hint View Unit \(self) is init!")
        }
        
        deinit {
            print("Hint View Unit \(self) is deinit; identifier = \(String(describing: identifier));")
        }
        
        // MARK: - Actions 
        
        /** SubView: Deploy views. Default will set the layer corner and shadow. */
        func deploy_at_init() {
            self.backgroundColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 0.9)
            layer.cornerRadius = 10
            layer.shadowRadius = 1
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize.zero
        }
        
        /** update the data */
        func update(data: Any) { }
        
        /** Update size at init, changed the unit's bounds. */
        func init_update_bounds() { }
        
        /** Start animation at init */
        func init_start_animation() { }
        
        /** Cell when user update the status datas */
        func result_deploy(type: Any) -> CGRect { return bounds }
        
        /** Cell when to update the frame */
        func result_update_bounds() { }
        
        /** Cell when to show. */
        func result_start_animation() { }
        
    }

}

