//
//  LocalizationTheme.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 9/3/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

enum LocalizationTheme: String, Localizable {
    var tableName: String {
        return "Theme"
    }
    
    case whiteTheme = "white theme"
    case blueTheme = "blue theme"
    case pinkTheme = "pink theme"
    case color = "color"
    case shadow = "shadow"
    case light = "light"
    case heavy = "heavy"
    case none = "none"
}
