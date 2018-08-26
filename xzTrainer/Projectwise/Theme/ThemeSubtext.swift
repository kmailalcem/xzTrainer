//
//  ThemeSubtext.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/23/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeSubtext: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        themeSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeSetUp()
    }
    
    func themeSetUp() {
        textColor = Theme.current.darkerLightTextColor
        font = UIFont.systemFont(ofSize: 15)
    }

}
