//
//  HintView_default_units.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class HintUnit_Image: HintView.HintUnit {
    
    let image_view: UIImageView = UIImageView()
    var image_view_size: CGSize = CGSize(width: 30, height: 30)
    
    override func deploy_at_init() {
        addSubview(image_view)
        self.backgroundColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 0.9)
        layer.cornerRadius = 10
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
    }
    
    override func update_size() {
        self.frame = CGRect(
            x: 0, y: 0,
            width: image_view_size.width > 30 ? image_view_size.width + 40 : 70,
            height: image_view_size.height > 30 ? image_view_size.height + 40 : 70
        )
        
        image_view.frame = CGRect(
            origin: CGPoint(
                x: (self.bounds.width - image_view_size.width) / 2,
                y: (self.bounds.height - image_view_size.height) / 2
            ),
            size: image_view_size
        )
    }
    
    override func update(data: Any) {
        if let size = data as? CGSize {
            image_view_size = size
        }
        else if let image = data as? UIImage {
            image_view.image = image
        }
        else if let duration = data as? TimeInterval {
            image_view.animationDuration = duration
        }
        else if let images = data as? [UIImage] {
            image_view.animationImages = images
        }
    }
    
    override func start() {
        if image_view.animationImages != nil {
            image_view.startAnimating()
        }
    }
}
