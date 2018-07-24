//
//  FloatingActionButton.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/2/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButton {
    @IBInspectable var size: CGFloat = 40 {
        didSet {
            frame = CGRect(x: center.x - size / 2, y: center.y - size / 2, width: size, height: size)
            layer.cornerRadius = size / 2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView?.image = imageView?.image!.withRenderingMode(.alwaysTemplate)
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8705882353, alpha: 1)
            } else {
                if !isSelected {
                    backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    tintColor = #colorLiteral(red: 0.1490196078, green: 0.4039215686, blue: 0.5803921569, alpha: 1)
                }
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                backgroundColor = #colorLiteral(red: 0.1342299879, green: 0.4006600678, blue: 0.5895091891, alpha: 1)
            } else {
                backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                tintColor = #colorLiteral(red: 0.1342299879, green: 0.4006600678, blue: 0.5895091891, alpha: 1)
            }
        }
    }
}
