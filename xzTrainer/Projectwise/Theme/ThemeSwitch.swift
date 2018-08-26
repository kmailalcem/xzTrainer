//
//  ThemeSwitch.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/31/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeSwitch: UISwitch {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        onTintColor = Theme.current.backgroundTintColor
        tintColor = Theme.current.darkerBackgroundColor
    }
    

}
