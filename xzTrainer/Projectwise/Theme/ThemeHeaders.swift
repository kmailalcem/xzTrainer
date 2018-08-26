//
//  ThemeHeader1.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/23/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeHeader1: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        themeSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        themeSetUp()
    }
    
    func themeSetUp() {
        font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textColor = Theme.current.headerTextColor
    }

}

class ThemeHeader2: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        themeSetUp()
    }
    
    func themeSetUp() {
        font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textColor = Theme.current.headerTextColor
    }
    
}
