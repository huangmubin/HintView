//
//  HintView_extension.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit
/*
extension UIView {
    
    // MARK: - Base
    
    func hint(unit: HintView.HintUnit) {
        HintView.display(
            to: self,
            unit: unit
        )
    }
    
    // MAKR: - Default Images or Default Images and Text
    
    func hint(success: String?) {
        var unit: HintView.HintUnit
        if let text = success {
            unit = HintUnit_Image_Text()
            unit.update(data: text)
        }
        else {
            unit = HintUnit_Image()
        }
        unit.update(data: HintView.ImageCache.checkmark)
        unit.update(data: CGSize(width: 30, height: 30))
        hint(unit: unit)
    }
    
    func hint(error: String?) {
        var unit: HintView.HintUnit
        if let text = error {
            unit = HintUnit_Image_Text()
            unit.update(data: text)
        }
        else {
            unit = HintUnit_Image()
        }
        unit.update(data: HintView.ImageCache.cross)
        unit.update(data: CGSize(width: 30, height: 30))
        hint(unit: unit)
    }
    
    func hint(info: String?) {
        var unit: HintView.HintUnit
        if let text = info {
            unit = HintUnit_Image_Text()
            unit.update(data: text)
        }
        else {
            unit = HintUnit_Image()
        }
        unit.update(data: HintView.ImageCache.info)
        unit.update(data: CGSize(width: 30, height: 30))
        hint(unit: unit)
    }
    
    // MARK: - Text
    
    func hint(text: String, width: CGFloat? = nil, font: UIFont? = nil, text_color: UIColor? = nil) {
        let unit = HintUnit_Text()
        unit.update(data: text)
        if let data = width {
            unit.update(data: data)
        }
        if let data = font {
            unit.update(data: data)
        }
        if let data = text_color {
            unit.update(data: data)
        }
        hint(unit: unit)
    }
    
    // MARK: - Loading
    
    @discardableResult
    func hint(loading: String, success_images: [UIImage] = [], error_images: [UIImage] = []) -> HintUnit_Loading {
        let unit = HintUnit_Loading()
        unit.update(data: loading)
        unit.success_images = success_images.isEmpty ? [HintView.ImageCache.checkmark] : success_images
        unit.error_images   = error_images.isEmpty ? [HintView.ImageCache.cross] : error_images
        hint(unit: unit)
        return unit
    }
    
}
*/
