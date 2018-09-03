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
        becomeObserver()
        themeSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeObserver()
        themeSetUp()
    }
    
    @objc func themeSetUp() {
        backgroundColor = Theme.current.fabBackgroundColor
        tintColor = Theme.current.fabTintColor
        layer.shadowOpacity = Float(Theme.current.shadowOpacity / 3)
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
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
