//
//  StoryboardExpander.swift
//  goldenRatio
//
//  Created by Masakaz Ozaki on 2019/01/03.
//  Copyright © 2019 Masakazu Ozaki. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map {
                UIColor(cgColor: $0)
            }
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor.map {
                UIColor(cgColor: $0)
            }
        } set {
            layer.shadowColor = newValue?.cgColor
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowAlpha: Float {
        get {
            return layer.shadowOpacity
        } set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }
}
