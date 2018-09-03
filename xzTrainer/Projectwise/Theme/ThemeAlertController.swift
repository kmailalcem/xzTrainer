//
//  BlueAlertController.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/30/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeAlertController: UIAlertController {
    @objc func themeSetUp() {
        let firstSubview = view.subviews.first
        let alertContentView = firstSubview?.subviews.first
        for subview in (alertContentView?.subviews)! {
            subview.backgroundColor = Theme.current.alertBackgroundColor
        }
        view.tintColor = Theme.current.backgroundTintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeSetUp()
        setValue(NSAttributedString(string: title!, attributes: [NSAttributedStringKey.foregroundColor : Theme.current.headerTextColor]), forKey: "attributedTitle")
        setValue(NSAttributedString(string: message!, attributes: [NSAttributedStringKey.foregroundColor : Theme.current.normalTextColor]), forKey: "attributedMessage")
    }

}
