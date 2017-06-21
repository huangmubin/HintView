//
//  HintView_extension.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

extension UIView {
    
    func hint(unit: HintView.HintUnit) {
        HintView.display(
            to: self,
            unit: unit
        )
    }
    
    func hint(success: String?) {
        var unit: HintView.HintUnit
        if let text = success {
            print(text)
            unit = HintView.HintUnit()
        }
        else {
            unit = HintUnit_Image()
            unit.update(data: HintView.ImageCache.checkmark)
            unit.update(data: CGSize(width: 30, height: 30))
        }
        hint(unit: unit)
    }
    
    func hint(error: String?) {
        var unit: HintView.HintUnit
        if let text = error {
            print(text)
            unit = HintView.HintUnit()
        }
        else {
            unit = HintUnit_Image()
            unit.update(data: HintView.ImageCache.cross)
            unit.update(data: CGSize(width: 30, height: 30))
        }
        hint(unit: unit)
    }
    
    func hint(info: String?) {
        var unit: HintView.HintUnit
        if let text = info {
            print(text)
            unit = HintView.HintUnit()
        }
        else {
            unit = HintUnit_Image()
            unit.update(data: HintView.ImageCache.info)
            unit.update(data: CGSize(width: 30, height: 30))
        }
        hint(unit: unit)
    }
    
}
