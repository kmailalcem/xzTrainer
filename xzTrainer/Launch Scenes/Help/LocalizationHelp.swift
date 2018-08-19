//
//  LocalizationHelp.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/19/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

enum LocalizationHelp: String, Localizable {
    var tableName: String {
        return "IconExplanations"
    }
    
    case plus = "+"
    case numpad = "numpad"
    case arrow = "arrow"
    case gear = "gear"
    case up = "up"
    case back = "back"
    case down = "down"
    case top = "top"
    case bottom = "bottom"
    case show = "show"
}
