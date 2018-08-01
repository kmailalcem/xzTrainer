//
//  BlueAlertController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/30/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class ThemeAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstSubview = view.subviews.first
        let alertContentView = firstSubview?.subviews.first
        for subview in (alertContentView?.subviews)! {
            subview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        view.tintColor = #colorLiteral(red: 0.3254901961, green: 0.4549019608, blue: 0.5843137255, alpha: 1)
        setValue(NSAttributedString(string: title!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0, green: 0.1529411765, blue: 0.2980392157, alpha: 1)]), forKey: "attributedTitle")
        setValue(NSAttributedString(string: message!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0, green: 0.1529411765, blue: 0.2980392157, alpha: 1)]), forKey: "attributedMessage")
    }

}
