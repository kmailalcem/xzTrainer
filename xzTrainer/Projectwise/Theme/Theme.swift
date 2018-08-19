//
//  Theme.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/19/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

struct Theme {
    let backgroundColor: UIColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8745098039, alpha: 1)
    let lighterBackgroundColor: UIColor = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.937254902, alpha: 1)
    let darkerBackgroundColor: UIColor = #colorLiteral(red: 0.5725490196, green: 0.6509803922, blue: 0.7450980392, alpha: 1)
    let backgroundTintColor: UIColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
    
    let normalTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let darkerLightTextColor = #colorLiteral(red: 0.2823529412, green: 0.4196078431, blue: 0.568627451, alpha: 1)
    let lighterLightTextColor = #colorLiteral(red: 0.6376282573, green: 0.7111827731, blue: 0.7914314866, alpha: 1)
    let headerTextColor = #colorLiteral(red: 0, green: 0.1529411765, blue: 0.2980392157, alpha: 1)
    let timerColor = #colorLiteral(red: 0.1342299879, green: 0.4006600678, blue: 0.5895091891, alpha: 1)
    
    let fabBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let fabTintColor = #colorLiteral(red: 0.1490196078, green: 0.4039215686, blue: 0.5803921569, alpha: 1)
    let fabHighlightedColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8745098039, alpha: 1)
    let fabSelectedColor = #colorLiteral(red: 0.1342299879, green: 0.4006600678, blue: 0.5895091891, alpha: 1)
    
    var shadowOpacity = 0.25
    
    static let defaultTheme = Theme()
    static var current = Theme.defaultTheme
}
