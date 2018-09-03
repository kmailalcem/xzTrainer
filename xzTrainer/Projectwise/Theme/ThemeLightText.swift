//
//  ThemeLightText.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/26/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeLightText: UILabel {
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
        DispatchQueue.main.async {
            self.textColor = Theme.current.lightTextColor
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
}
