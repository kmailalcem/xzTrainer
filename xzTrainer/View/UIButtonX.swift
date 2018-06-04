//
//  UIButtonX.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/3/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class UIButtonX: UIButton {
    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadious
        }
    }
}
