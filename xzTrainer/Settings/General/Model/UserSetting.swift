//
//  UserSettings.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/7/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class UserSetting {
    var general: GeneralSetting
    var encoder: EncoderSetting
    
    public static var shared: UserSetting {
        if UserSetting.singleton == nil {
            UserSetting.singleton = UserSetting()
        }
        return UserSetting.singleton!
    }
    
    private static var singleton: UserSetting?
    private init() {
        general = GeneralSetting()
        encoder = EncoderSetting()
    }
}
