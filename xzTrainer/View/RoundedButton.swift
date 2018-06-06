//
//  RoundedButton.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/27/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {

    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadious
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor(red: 0x92/255, green: 0xa6/255, blue: 0xbe/255, alpha: 1)
            } else {
                self.backgroundColor = UIColor(red: 0, green: 0x27/255, blue: 0x4c/255, alpha: 0.9)
            }
        }
    }
}
