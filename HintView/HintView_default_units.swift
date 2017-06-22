//
//  HintView_default_units.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

// MARK: - HintUnit - Image

class HintUnit_Image: HintView.HintUnit {
    
    let image_view: UIImageView = UIImageView()
    var image_view_size: CGSize = CGSize(width: 30, height: 30)
    
    override func deploy_at_init() {
        super.deploy_at_init()
        addSubview(image_view)
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

// MARK: - HintUnit - Text

class HintUnit_Text: HintView.HintUnit {
    
    let label: UILabel = UILabel()
    var label_max_width: CGFloat = 0
    
    override func deploy_at_init() {
        super.deploy_at_init()
        label_max_width = UIScreen.main.bounds.width / 2
        label.textColor = UIColor.white
        label.numberOfLines = 0
        addSubview(label)
    }
    
    override func update_size() {
        label.frame = CGRect(x: 0, y: 0, width: label_max_width, height: 1000000)
        label.sizeToFit()
        
        self.frame = CGRect(
            x: 0, y: 0,
            width: label.bounds.width > 40 ? label.bounds.width + 30 : 70,
            height: label.bounds.height > 30 ? label.bounds.height + 30 : 60
        )
        
        label.center = CGPoint(
            x: self.bounds.width / 2,
            y: self.bounds.height / 2
        )
    }
    
    override func update(data: Any) {
        if let size = data as? CGFloat {
            label_max_width = size
        }
        else if let text = data as? String {
            label.text = text
        }
        else if let font = data as? UIFont {
            label.font = font
        }
        else if let color = data as? UIColor {
            label.textColor = color
        }
    }
    
}

// MARK: - HintUnit - Image + Text

class HintUnit_Image_Text: HintView.HintUnit {
    
    let image_view: UIImageView = UIImageView()
    var image_view_size: CGSize = CGSize(width: 30, height: 30)
    
    let label: UILabel = UILabel()
    var label_max_width: CGFloat = 0
    
    override func deploy_at_init() {
        super.deploy_at_init()
        addSubview(image_view)
        
        label_max_width = UIScreen.main.bounds.width / 2
        label.textColor = UIColor.white
        label.numberOfLines = 0
        addSubview(label)
    }
    
    override func update_size() {
        label.frame = CGRect(x: 0, y: 0, width: label_max_width, height: 1000000)
        label.sizeToFit()
        
        let width = max(label.bounds.width, image_view_size.width)
        let height = label.bounds.height + image_view_size.height + 10
        
        self.frame = CGRect(
            x: 0, y: 0,
            width: width > 62 ? width + 40 : 102,
            height: height > 62 ? height + 40 : 102
        )
        
        image_view.bounds.size = image_view_size
        image_view.center = CGPoint(
            x: self.bounds.width / 2,
            y: self.bounds.height / 2 - (self.label.bounds.height + 10) / 2
        )
        
        label.center = CGPoint(
            x: self.bounds.width / 2,
            y: self.bounds.height / 2 + (self.image_view.bounds.height + 10) / 2
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
        else if let size = data as? CGFloat {
            label_max_width = size
        }
        else if let text = data as? String {
            label.text = text
        }
        else if let font = data as? UIFont {
            label.font = font
        }
        else if let color = data as? UIColor {
            label.textColor = color
        }
    }
    
    override func start() {
        if image_view.animationImages != nil {
            image_view.startAnimating()
        }
    }
    
}

// MARK: - HintUnit - Loading

class HintUnit_Loading: HintUnit_Image_Text {
    
    let activity: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    var success_images: [UIImage] = []
    var error_images  : [UIImage] = []
    
    override func deploy_at_init() {
        self.duration_time = 100000000
        super.deploy_at_init()
        addSubview(activity)
        image_view.isHidden = true
        activity.hidesWhenStopped = true
        activity.startAnimating()
    }
    
    override func update_size() {
        super.update_size()
        activity.center = image_view.center
    }
    
    override func update(data: Any) {
        super.update(data: data)
    }
    
    override func start() {
        activity.startAnimating()
    }
    
    func update(result: Bool?, text: String?) {
        if let result = result {
            self.dismiss_time = Date().timeIntervalSince1970 + 3
            self.activity.stopAnimating()
            self.label.text = text
            self.image_view.isHidden = false
            if result {
                if self.success_images.count > 1 {
                    self.image_view.animationImages = self.success_images
                    self.image_view.startAnimating()
                }
                else {
                    self.image_view.image = self.success_images.first
                }
            }
            else {
                if self.error_images.count > 1 {
                    self.image_view.animationImages = self.error_images
                    self.image_view.startAnimating()
                }
                else {
                    self.image_view.image = self.error_images.first
                }
            }
            let center = self.center
            update_size()
            self.center = center
        }
        else {
            self.duration_time = 0
        }
    }
    
}
