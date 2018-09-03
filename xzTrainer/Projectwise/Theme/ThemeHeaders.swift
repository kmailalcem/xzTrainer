//
//  ThemeHeader1.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/23/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeHeader1: UILabel, ThemeElement {

    override init(frame: CGRect) {
        super.init(frame: frame)
        becomeObserver()
        themeSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeObserver()
        themeSetUp()
    }
    
    @objc func themeSetUp() {
        font = UIFont.systemFont(ofSize: 20, weight: .medium)
        DispatchQueue.main.async {
            self.textColor = Theme.current.headerTextColor
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }

}

class ThemeHeader2: UILabel, ThemeElement {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        becomeObserver()
        themeSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        becomeObserver()
        themeSetUp()
    }
    
    @objc func themeSetUp() {
        font = UIFont.systemFont(ofSize: 17, weight: .medium)
        DispatchQueue.main.async {
            self.textColor = Theme.current.headerTextColor
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
    
}