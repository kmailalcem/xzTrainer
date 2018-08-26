//
//  ThemeTimeText.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/26/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeTimeText: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        themeSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeSetUp()
    }
    
    func themeSetUp() {
        textColor = Theme.current.timerColor
        font = UIFont.systemFont(ofSize: 40, weight: .medium)
    }

}
