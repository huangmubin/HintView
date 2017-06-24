//
//  HintView_extension.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Base
    
    func hint(unit: HintView.HintUnit) {
        HintView.display(
            unit: unit,
            to: self
        )
    }
    
    // MAKR: - Default Images or Default Images and Text
    
    private func hint(image: UIImage, text: String?) {
        var unit: HintView.HintUnit
        if let text = text {
            unit = HintView.Unit_Teletext()
            unit.update(data: text)
        }
        else {
            unit = HintView.Unit_Image()
        }
        unit.update(data: image)
        unit.update(data: CGSize(width: 30, height: 30))
        hint(unit: unit)
    }
    
    func hint(success text: String?) {
        hint(image: HintView.ImageCache.checkmark, text: text)
    }
    
    func hint(error text: String?) {
        hint(image: HintView.ImageCache.cross, text: text)
    }
    
    func hint(info text: String?) {
        hint(image: HintView.ImageCache.info, text: text)
    }
    
    // MARK: - Text
    
    func hint(text: String, width: CGFloat? = nil, font: UIFont? = nil, text_color: UIColor? = nil) {
        let unit = HintView.Unit_Text()
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
    func hint(loading: String, success_images: [UIImage] = [], error_images: [UIImage] = []) -> HintView.Unit_Loading {
        let unit = HintView.Unit_Loading()
        unit.update(data: loading)
        unit.success_images = success_images.isEmpty ? [HintView.ImageCache.checkmark] : success_images
        unit.error_images   = error_images.isEmpty ? [HintView.ImageCache.cross] : error_images
        unit.identifier = "Loading"
        hint(unit: unit)
        return unit
    }
    
}
