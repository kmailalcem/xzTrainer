//
//  FloatingActionButton.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/2/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
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
        backgroundColor = Theme.current.fabBackgroundColor
        tintColor = Theme.current.fabTintColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.083
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = Theme.current.fabHighlightedColor
            } else {
                if !isSelected {
                    backgroundColor = Theme.current.fabBackgroundColor
                    tintColor = Theme.current.fabTintColor
                }
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                tintColor = Theme.current.fabBackgroundColor
                backgroundColor = Theme.current.fabSelectedColor
            } else {
                backgroundColor = Theme.current.fabBackgroundColor
                tintColor = Theme.current.fabTintColor
            }
        }
    }
}
