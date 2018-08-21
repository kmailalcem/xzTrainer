//
//  LocalizationGeneral.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/16/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation
enum LocalizationGeneral: String, Localizable {
    var tableName: String {
        return "Localizable"
    }
    
    case timerMessage1 = "timer didn't start message 1"
    case timerMessage2 = "timer didn't start message 2"
    case morningGreeting = "morning greeting"
    case afternoonGreeting = "afternoon greeting"
    case eveningGreeting = "evening greeting"
    case defaultUserName = "default user name"
    case firstLetter = "first in letter pair"
    case cancel = "cancel"
    case done = "done"
    case manuallyEnterTime = "manually enter time"
    case enterYourTime = "enter your time"
    case delete = "delete"
    case clear = "clear"
    case rename = "rename"
    case areYouSure = "are you sure"
    case yes = "yes"
    case defaultt = "default"
    case newName = "new name"
    case newSession = "new session"
    case renameSession = "rename session"
    case clearWarning = "clear warning"
    case deleteWarning = "delete warning"
    case renameSessionMessage = "rename session message"
    case newSessionMessage = "new session message"
}
