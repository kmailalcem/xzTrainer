//
//  UIButtonX.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/3/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit


class UIButtonX: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        becomeObserver()
        themeSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeObserver()
        themeSetUp()
    }
    
    @objc func themeSetUp() {
        DispatchQueue.main.async {
            self.layer.borderColor = Theme.current.backgroundTintColor.cgColor
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
    
    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadious
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
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = Theme.current.backgroundTintColor.cgColor
        }
    }
}
