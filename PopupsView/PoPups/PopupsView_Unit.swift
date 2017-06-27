//
//  PopupsView_Unit.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/24.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

extension PopupsView {
    
    // MARK: - Base Unit
    
    /** Display unit. */
    class Unit: UIView {
        
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
        
        private func deploy() {
            self.backgroundColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 0.9)
            layer.cornerRadius = 10
            layer.shadowRadius = 1
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize.zero
            
            content_text.textColor = UIColor.white
            content_text.numberOfLines = 0
            
            addSubview(content_text)
            addSubview(content_view)
        }
        
        // MARK: - Data
        
        /** Unit identifier */
        var identifier: String?
        
        // MARK: Time
        
        /** display duration, default is 3. */
        var display_duration: TimeInterval = 3
        /** Dismiss time interval since 1970. */
        var dismiss_time: TimeInterval = 0
        
        // MARK: Dictionary
        
        /** Any datas */
        var datas: [String: Any] = [:]
        
        var label_text: String? {
            return datas["content_text.text"] as? String
        }
        var view_image: UIImage? {
            return datas["content_view.image"] as? UIImage
        }
        var view_images: [UIImage]? {
            return datas["content_view.animationImages"] as? [UIImage]
        }
        
        // MARK: View
        
        /** Content View */
        var content_view: UIImageView = UIImageView()
        /** Content Text */
        var content_text: UILabel = UILabel()
        
        /** Content view size */
        var content_view_size: CGSize = CGSize(width: 30, height: 30)
        /** Content text width */
        var content_text_width: CGFloat = UIScreen.main.bounds.width / 2
        
        /** Content view is hidden */
        var content_view_hidden: Bool = false
        /** Content text is hidden */
        var content_text_hidden: Bool = false
        
        // MARK: - Layout Actions
        
        /** Count the content size. */
        func content_size() -> CGSize {
            return self.bounds.size
        }
        
        /** Reconfigure the layout of the child views. */
        func content_reconfigure() {
            content_view.image = view_image
            content_view.animationImages = view_images
        }
        
        /**  */
        final func content_text_size_to_fit() {
            content_text.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(
                    width: content_text_width,
                    height: 1000000
                )
            )
            content_text.sizeToFit()
        }
        
        // MARK: - Data Actions
        
        static let key_content_text = "content_text.text"
        static let key_content_image = "content_view.image"
        static let key_content_images = "content_view.animationImages"
        static let key_content_size = "content_view_size"
        static let key_content_width = "content_text_width"
        static let key_view_hidden = "content_view_hidden"
        static let key_text_hidden = "content_text_hidden"
        
        /** Update datas */
        func update(key: String, data: Any) {
            datas[key] = data
            if let text = data as? String {
                if key == "content_text.text" {
                    content_text.text = text
                }
            }
            else if let image = data as? UIImage {
                if key == "content_view.image" {
                    content_view.image = image
                }
            }
            else if let images = data as? [UIImage] {
                if key == "content_view.animationImages" {
                    content_view.animationImages = images
                }
            }
            else if let size = data as? CGSize {
                if key == "content_view_size" {
                    content_view_size = size
                }
            }
            else if let width = data as? CGFloat {
                if key == "content_text_width" {
                    content_text_width = width
                }
            }
            else if let hidden = data as? Bool {
                if key == "content_view_hidden" {
                    content_view_hidden = hidden
                }
                else if key == "content_text_hidden" {
                    content_text_hidden = hidden
                }
            }
        }
        
        /** Update the data of the child views. */
        func update_views_data() {
            
        }
        
        // MARK: - Tools
        
        /** Count the label size. */
        final func label_size(text: String, width: CGFloat, label: UILabel? = nil) -> CGSize {
            let temp_label = UILabel()
            temp_label.text = text
            temp_label.numberOfLines = 0
            temp_label.frame = CGRect(x: 0, y: 0, width: width, height: 1000000)
            if let label = label {
                temp_label.textColor = label.textColor
                temp_label.font = label.font
                temp_label.attributedText = label.attributedText
                temp_label.textAlignment = label.textAlignment
            }
            temp_label.sizeToFit()
            return temp_label.bounds.size
        }
        
        /** Count the frame with the size and center. */
        final func frame(size: CGSize, center: CGPoint) -> CGRect {
            return CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
        }
        
    }
    
    // MARK: - Center Unit
    
    /** Display unit in center. */
    class CenterUnit: PopupsView.Unit {
        
        // MARK: - Actions
        
        /** Count the content size. */
        override func content_size() -> CGSize {
            var size: CGSize = CGSize.zero
            
            // View
            if content_view_hidden {
                size.height = -10
            }
            else {
                size = content_view_size
            }
            
            // Text
            if !content_text_hidden {
                if let text = label_text {
                    let text_size = label_size(
                        text: text,
                        width: content_text_width,
                        label: content_text
                    )
                    size.height = size.height + text_size.height + 10
                    size.width = max(size.width, text_size.width)
                }
            }
            
            // Edge
            size.width = size.width > 30 ? size.width + 40 : 70
            size.height = size.height > 30 ? size.height + 40 : 70
            
            return size
        }
        
        /** Reconfigure the layout of the child views. */
        override func content_reconfigure() {
            super.content_reconfigure()
            
            // Bounds
            self.frame = frame(
                size: content_size(),
                center: self.center
            )
            
            // View
            content_view.isHidden = content_view_hidden
            
            // Text
            if content_text_hidden {
                content_text.isHidden = true
            }
            else {
                content_text.isHidden = false
                content_text.text = label_text
                content_text_size_to_fit()
            }
            
            // Frame
            if content_view_hidden && !content_text_hidden {
                content_text.frame = CGRect(
                    x: (bounds.width - content_text.bounds.width) / 2,
                    y: (bounds.height - content_text.bounds.height) / 2,
                    width: content_text.bounds.width,
                    height: content_text.bounds.height
                )
            }
            else if !content_view_hidden && content_text_hidden {
                content_view.frame = CGRect(
                    x: (bounds.width - content_view_size.width) / 2,
                    y: (bounds.height - content_view_size.height) / 2,
                    width: content_view_size.width,
                    height: content_view_size.height
                )
            }
            else if !content_view_hidden && !content_text_hidden {
                content_view.frame = CGRect(
                    x: (bounds.width - content_view_size.width) / 2,
                    y: (bounds.height - content_view_size.height - content_text.bounds.height - 10) / 2,
                    width: content_view_size.width,
                    height: content_view_size.height
                )
                content_text.frame = CGRect(
                    x: (bounds.width - content_text.bounds.width) / 2,
                    y: content_view.frame.maxY + 10,
                    width: content_text.bounds.width,
                    height: content_text.bounds.height
                )
            }
        }
        
    }
    
    // MARK: - Bottom Unit
    
    class BottomUnit: Unit {
        
        // MARK: - Actions
        
        /** Count the content size. */
        override func content_size() -> CGSize {
            var size: CGSize = CGSize.zero
            
            // View
            if content_view_hidden {
                size.width = -10
            }
            else {
                size = content_view_size
            }
            
            // Text
            if !content_text_hidden {
                if let text = label_text {
                    let text_size = label_size(
                        text: text,
                        width: content_text_width,
                        label: content_text
                    )
                    size.width = size.width + text_size.width + 10
                    size.height = max(size.height, text_size.height)
                }
            }
            
            // Edge
            size.width = size.width > 110 ? size.width + 30 : 140
            size.height = size.height > 30 ? size.height + 24 : 54
            
            return size
        }
        
        /** Reconfigure the layout of the child views. */
        override func content_reconfigure() {
            super.content_reconfigure()
            
            // Bounds
            self.frame = frame(
                size: content_size(),
                center: self.center
            )
            
            // View
            content_view.isHidden = content_view_hidden
            
            // Text
            if content_text_hidden {
                content_text.isHidden = true
            }
            else {
                content_text.isHidden = false
                content_text.text = label_text
                content_text_size_to_fit()
            }
            
            // Frame
            if content_view_hidden && !content_text_hidden {
                content_text.frame = CGRect(
                    x: (bounds.width - content_text.bounds.width) / 2,
                    y: (bounds.height - content_text.bounds.height) / 2,
                    width: content_text.bounds.width,
                    height: content_text.bounds.height
                )
            }
            else if !content_view_hidden && content_text_hidden {
                content_view.frame = CGRect(
                    x: (bounds.width - content_view_size.width) / 2,
                    y: (bounds.height - content_view_size.height) / 2,
                    width: content_view_size.width,
                    height: content_view_size.height
                )
            }
            else if !content_view_hidden && !content_text_hidden {
                content_view.frame = CGRect(
                    x: (bounds.width - content_view_size.width - content_text.bounds.width - 10) / 2,
                    y: (bounds.height - content_view_size.height) / 2,
                    width: content_view_size.width,
                    height: content_view_size.height
                )
                content_text.frame = CGRect(
                    x: content_view.frame.maxX + 10,
                    y: (bounds.height - content_text.bounds.height) / 2,
                    width: content_text.bounds.width,
                    height: content_text.bounds.height
                )
            }
        }
        
    }
    
}
