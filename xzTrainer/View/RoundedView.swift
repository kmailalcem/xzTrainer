//
//  RoundedView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/27/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

@IBDesignable class RoundedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0 {
        didSet {
            layer.shadowOffset.width = shadowOffsetWidth
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetHeight
        }
    }

}
