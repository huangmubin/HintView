//
//  PopupsView_extension.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/24.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Base
    
    func popups(unit: PopupsView.Unit) {
        PopupsView.display(
            unit: unit,
            to: self
        )
    }
    
    private func popups(image: UIImage?, text: String?, at_center: Bool) {
        let unit: PopupsView.Unit = at_center ? PopupsView.CenterUnit() : PopupsView.BottomUnit()
        if let text = text {
            unit.update(
                key: PopupsView.Unit.key_content_text,
                data: text
            )
        }
        else {
            unit.update(
                key: PopupsView.Unit.key_text_hidden,
                data: true
            )
        }
        if let image = image {
            unit.update(
                key: PopupsView.Unit.key_content_image,
                data: image
            )
        }
        else {
            unit.update(
                key: PopupsView.Unit.key_view_hidden,
                data: true
            )
        }
        popups(unit: unit)
    }
    
    // MARK: - Text
    
    func popups(text: String, at_center: Bool = true) {
        popups(image: nil, text: text, at_center: at_center)
    }
    
    // MARK: - Success, Error, Info
    
    func popups(success text: String?, at_center: Bool = true) {
        popups(
            image: PopupsView.ImageCache.checkmark,
            text: text,
            at_center: at_center
        )
    }
    
    func popups(error text: String?, at_center: Bool = true) {
        popups(
            image: PopupsView.ImageCache.cross,
            text: text,
            at_center: at_center
        )
    }
    
    func popups(info text: String?, at_center: Bool = true) {
        popups(
            image: PopupsView.ImageCache.info,
            text: text,
            at_center: at_center
        )
    }
    
}
