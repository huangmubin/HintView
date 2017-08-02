//
//  PopupsView_Progress.swift
//  PopupViews
//
//  Created by Myron on 2017/6/27.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

class PopupsView_Progress: PopupsView {
    
    var progress_size: CGSize = CGSize(width: 200, height: 20)
    var progress: PopupsView_Progress.Progress = PopupsView_Progress.Progress()
    var label: UILabel = UILabel()
    
    // MARK: - Init
    
    /** Deploy action at init. */
    override func deploy_at_init() {
        run_duration = 0
        
        super.deploy_at_init()
        
        addSubview(progress)
        progress.frame = CGRect(x: 50, y: 100, width: 200, height: 20)
        
        addSubview(label)
        label.numberOfLines = 0
        label.textColor = UIColor.white
    }
    
    // MARK: - Subview override.
    
    /** Cell when init. */
    override func update_content_layout() {
        if label.text?.isEmpty == false {
            label.frame = CGRect(
                x: 0, y: 0,
                width: progress_size.width + 40,
                height: 10000000
            )
            label.sizeToFit()
            
            let width = max(label.bounds.width, progress_size.width)
            let height = label.bounds.height + progress_size.height + 4
            
            label.center = CGPoint(
                x: bounds.width / 2,
                y: (bounds.height - progress_size.height - 4) / 2
            )
            progress.frame = CGRect(
                x: (bounds.width - progress_size.width) / 2,
                y: label.frame.maxY + 4,
                width: progress_size.width,
                height: progress_size.height
            )
            
            content_view.bounds.size = CGSize(
                width: width + 40,
                height: height + 40
            )
        }
        else {
            progress.frame = CGRect(
                x: (bounds.width - progress_size.width) / 2,
                y: (bounds.height - progress_size.height) / 2,
                width: progress_size.width,
                height: progress_size.height
            )
            
            content_view.bounds.size = CGSize(
                width: progress_size.width + 40,
                height: progress_size.height + 40
            )
        }
        
        super.update_center_layout()
    }
    
    /** Update datas */
    override func update(data: Any) {
        if let value = data as? CGFloat {
            progress.value = value
        }
    }
    
    
}

// MARK: - PopupsView Progress View

extension PopupsView_Progress {
    
    class Progress: UIView {
        
        var layer_border: CALayer = CALayer()
        var layer_filler: CAShapeLayer = CAShapeLayer()
        var layer_color: CGColor = UIColor.white.cgColor
        
        var value: CGFloat = 0 {
            didSet {
                layer_filler.strokeEnd = value
                label.text = String(format: "%.0f %%", value * 100)
                label.sizeToFit()
                label.center = CGPoint(
                    x: bounds.width / 2,
                    y: bounds.height / 2
                )
                label.textColor = value >= 0.48 ? UIColor.black : UIColor.white
            }
        }
        
        // MARK: - Init
        
        init() {
            super.init(frame: UIScreen.main.bounds)
            deploy()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            deploy()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            deploy()
        }
        let label = UILabel()
        
        private func deploy() {
            layer.addSublayer(layer_border)
            layer_border.borderColor = layer_color
            layer_border.backgroundColor = UIColor.clear.cgColor
            layer_border.borderWidth = 2
            
            layer.addSublayer(layer_filler)
            layer_filler.strokeColor = layer_color
            layer_filler.strokeEnd = 1
            layer_filler.lineCap = kCALineCapRound
            
            update_layers()
            
            addSubview(label)
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: bounds.height / 2 - 4)
        }
        
        // MARK: - Frame
        
        override var frame: CGRect {
            didSet {
                if frame.size != oldValue.size {
                    update_layers()
                }
            }
        }
        
        override var bounds: CGRect {
            didSet {
                if bounds.size != oldValue.size {
                    update_layers()
                }
            }
        }
        
        // MARK: - Update Layers
        
        func update_layers() {
            let center_y = bounds.height / 2
            
            layer_border.frame = bounds
            layer_border.cornerRadius = center_y
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: center_y, y: center_y))
            path.addLine(to: CGPoint(x: bounds.width - center_y, y: center_y))
            layer_filler.path = path.cgPath
            layer_filler.lineWidth = center_y - 2
            
            label.font = UIFont.systemFont(ofSize: bounds.height / 2 - 4)
            label.center = CGPoint(
                x: bounds.width / 2,
                y: bounds.height / 2
            )
        }
        
    }
    
}
