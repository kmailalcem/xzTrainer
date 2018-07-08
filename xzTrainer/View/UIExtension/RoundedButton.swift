//
//  RoundedButton.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/27/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadious
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6509803922, blue: 0.7450980392, alpha: 1)
            } else {
                self.backgroundColor = #colorLiteral(red: 0, green: 0.1529411765, blue: 0.2980392157, alpha: 0.9)
            }
        }
    }
}
