//
//  File.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/16/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

enum LocalizableMode: String, Localizable {
    var tableName: String {
        return "Mode"
    }
    
    case executionTraining = "Execution Training"
    case casualBLD = "Casual BLD"
}
