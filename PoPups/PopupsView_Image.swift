//
//  PopupsView_Image.swift
//  PopupViews
//
//  Created by Myron on 2017/6/27.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

class PopupsView_Image: PopupsView {
    
    // MARK: - Datas
    
    var image_size: CGSize = CGSize(width: 30, height: 30)
    var image_image: UIImage? {
        didSet {
            content_image.image = image_image
            image_hidden = image_image == nil
        }
    }
    var label_text: String? {
        didSet {
            content_label.text = label_text
            label_hidden = !(label_text?.isEmpty == false)
        }
    }
    var label_width: CGFloat = UIScreen.main.bounds.width / 2
    
    var image_hidden: Bool = false
    var label_hidden: Bool = false
    
    // MARK: - Content Views
    
    var content_image: UIImageView = UIImageView()
    var content_label: UILabel = UILabel()
    
    // MARK: - init
    
    override func deploy_at_init() {
        super.deploy_at_init()
        addSubview(content_image)
        addSubview(content_label)
        content_label.numberOfLines = 0
        content_label.textColor = UIColor.white
    }
    
    // MARK: - Views Layout
    
    override func update_center_layout() {
        content_image.isHidden = image_hidden
        content_label.isHidden = label_hidden
        
        //
        switch (image_hidden, label_hidden) {
        case (false, true):
            content_image.center = CGPoint(
                x: bounds.width / 2,
                y: bounds.height / 2
            )
        case (true, false):
            content_label.center = CGPoint(
                x: bounds.width / 2,
                y: bounds.height / 2
            )
        default:
            content_image.frame = CGRect(
                x: (bounds.width - image_size.width) / 2 ,
                y: (bounds.height - image_size.height - content_label.bounds.height - 10) / 2,
                width: image_size.width,
                height: image_size.height
            )
            
            content_label.center = CGPoint(
                x: bounds.width / 2,
                y: content_image.frame.maxY + 10 + content_label.bounds.height / 2
            )
        }
        
        super.update_center_layout()
    }
    
    override func update_content_layout() {
        switch (image_hidden, label_hidden) {
        case (false, true):
            content_image.frame = CGRect(
                x: (bounds.width - image_size.width) / 2 ,
                y: (bounds.height - image_size.height) / 2,
                width: image_size.width,
                height: image_size.height
            )
            
            content_view.frame.size = CGSize(
                width: image_size.width > 30 ? image_size.width + 40 : 70,
                height: image_size.height > 30 ? image_size.height + 40 : 70
            )
        case (true, false):
            content_label.frame = CGRect(x: 0, y: 0, width: label_width, height: 1000000)
            content_label.sizeToFit()
            content_label.center = CGPoint(
                x: bounds.width / 2,
                y: bounds.height / 2
            )
            
            content_view.frame.size = CGSize(
                width: content_label.bounds.width > 30 ? content_label.bounds.width + 40 : 70,
                height: content_label.bounds.height > 30 ? content_label.bounds.height + 40 : 70
            )
        default:
            content_label.frame = CGRect(x: 0, y: 0, width: label_width, height: 1000000)
            content_label.sizeToFit()
            
            content_image.frame = CGRect(
                x: (bounds.width - image_size.width) / 2 ,
                y: (bounds.height - image_size.height - content_label.bounds.height - 10) / 2,
                width: image_size.width,
                height: image_size.height
            )
            
            content_label.center = CGPoint(
                x: bounds.width / 2,
                y: content_image.frame.maxY + 10 + content_label.bounds.height / 2
            )
            
            let width = max(image_size.width, content_label.bounds.width)
            let height = image_size.height + content_label.bounds.height + 10
            
            content_view.frame.size = CGSize(
                width: width > 30 ? width + 40 : 70,
                height: height > 30 ? height + 40 : 70
            )
        }
        
        content_view.center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height / 2
        )
        
        content_button.center = CGPoint(
            x: bounds.width / 2 + content_button_offset.x,
            y: bounds.height - 60 + content_button_offset.y
        )
    }
    
    
    // MARK: - Display and Dismiss
    
    override func display_completion() {
        if content_image.animationImages != nil {
            content_image.startAnimating()
        }
    }
}
