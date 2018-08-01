//
//  ThemeSwitch.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/31/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
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
        onTintColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
        tintColor = #colorLiteral(red: 0.6352941176, green: 0.7803921569, blue: 0.9882352941, alpha: 1)
    }
    

}
