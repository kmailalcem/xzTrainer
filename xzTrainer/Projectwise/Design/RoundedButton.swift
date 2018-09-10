//
//  RoundedButton.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/27/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        themeSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeSetUp()
    }
    
    func themeSetUp() {
        backgroundColor = Theme.current.invertedBackgroundColor
        setTitleColor(Theme.current.invertedTexTColor, for: .highlighted)
        setTitleColor(Theme.current.invertedTexTColor, for: .normal)
        setTitleColor(Theme.current.invertedBackgroundColor, for: .selected)
    }

    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadious
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = Theme.current.invertedBackgroundColor.withAlphaComponent(0.15)
            } else {
                self.backgroundColor = Theme.current.invertedBackgroundColor
            }
        }
    }

}
