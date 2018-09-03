//
//  ThemeSwitch.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/31/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeSwitch: UISwitch, ThemeElement {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeObserver()
        themeSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        becomeObserver()
        themeSetUp()
    }
    
    @objc func themeSetUp() {
        onTintColor = Theme.current.backgroundTintColor
        tintColor = Theme.current.darkerBackgroundColor
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
}
