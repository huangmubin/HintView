//
//  PopusView_image.swift
//  PopupViews
//
//  Created by Myron on 2017/6/27.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

extension PopupsView {
    
    struct ImageCache {
        static var _checkmark: UIImage?
        static var _cross: UIImage?
        static var _info: UIImage?
        
        static var checkmark: UIImage {
            if let image = _checkmark {
                return image
            }
            else {
                UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
                let path = UIBezierPath()
                // draw circle
                path.move(to: CGPoint(x: 36, y: 18))
                path.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
                path.close()
                
                path.move(to: CGPoint(x: 10, y: 18))
                path.addLine(to: CGPoint(x: 16, y: 24))
                path.addLine(to: CGPoint(x: 27, y: 13))
                path.move(to: CGPoint(x: 10, y: 18))
                path.close()
                
                UIColor.white.setStroke()
                path.stroke()
                
                _checkmark = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return _checkmark!
            }
        }
        static var cross: UIImage {
            if let image = _cross {
                return image
            }
            else {
                UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
                let path = UIBezierPath()
                // draw circle
                path.move(to: CGPoint(x: 36, y: 18))
                path.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
                path.close()
                
                path.move(to: CGPoint(x: 10, y: 10))
                path.addLine(to: CGPoint(x: 26, y: 26))
                path.move(to: CGPoint(x: 10, y: 26))
                path.addLine(to: CGPoint(x: 26, y: 10))
                path.move(to: CGPoint(x: 10, y: 10))
                path.close()
                
                UIColor.white.setStroke()
                path.stroke()
                
                _cross = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return _cross!
            }
        }
        static var info: UIImage {
            if let image = _info {
                return image
            }
            else {
                UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 36, y: 18))
                path.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
                path.close()
                
                path.move(to: CGPoint(x: 18, y: 6))
                path.addLine(to: CGPoint(x: 18, y: 22))
                path.move(to: CGPoint(x: 18, y: 6))
                path.close()
                
                UIColor.white.setStroke()
                path.stroke()
                
                let path_arc = UIBezierPath()
                path_arc.move(to: CGPoint(x: 18, y: 27))
                path_arc.addArc(withCenter: CGPoint(x: 18, y: 27), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
                path_arc.close()
                
                UIColor.white.setFill()
                path_arc.fill()
                
                _info = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return _info!
            }
        }
    }
    
}
