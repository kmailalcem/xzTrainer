//
//  UserDefaultsHandler.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/17/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

func keyExists(_ key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

func storedValue<T>(forKey key: String, defaultValue: T) -> T {
    if keyExists(key) {
        return UserDefaults.standard.value(forKey: key) as! T
    } else {
        return defaultValue
    }
}
