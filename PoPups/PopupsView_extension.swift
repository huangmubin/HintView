//
//  PopupsView_extension.swift
//  PopupViews
//
//  Created by Myron on 2017/6/27.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Update Value
    
    func popup(update value: Any) {
        for subview in subviews {
            if let view = subview as? PopupsView {
                view.update(data: value)
                break
            }
        }
    }
    
    // MARK: - Success Error Info
    
    func popup(image: UIImage?, text: String?, offset: CGPoint? = nil) {
        let view = PopupsView_Image()
        view.image_image = image
        view.label_text = text
        view.image_hidden = (image == nil)
        view.label_hidden = (text == nil)
        if let offset = offset {
            view.content_button_offset = offset
        }
        else {
            view.content_button.isHidden = true
        }
        view.display(to: self)
    }
    
    func popup(success text: String?, offset: CGPoint? = nil) {
        popup(image: PopupsView.ImageCache.checkmark, text: text, offset: offset)
    }
    func popup(error text: String?, offset: CGPoint? = nil) {
        popup(image: PopupsView.ImageCache.cross, text: text, offset: offset)
    }
    func popup(info text: String?, offset: CGPoint? = nil) {
        popup(image: PopupsView.ImageCache.info, text: text, offset: offset)
    }

    // MARK: - Loading
    
    @discardableResult
    func popup(loading text: String?) -> PopupsView_Loading {
        let view = PopupsView_Loading()
        view.label_text = text
        view.label_hidden = (text == nil)
        view.display(to: self)
        return view
    }
    
    @discardableResult
    func popup(progress text: String?) -> PopupsView_Progress {
        let view = PopupsView_Progress()
        view.display(to: self)
        return view
    }
    
    
    
}
