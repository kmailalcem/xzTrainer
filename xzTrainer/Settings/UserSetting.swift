//
//  UserSettings.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/7/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

class UserSetting {
    var general: GeneralSetting
    var _encoder: EncoderSetting?
    var encoder: EncoderSetting {
        if _encoder == nil {
            _encoder = EncoderSetting()
        }
        return _encoder!
    }
    
    public static var shared: UserSetting {
        if UserSetting.singleton == nil {
            UserSetting.singleton = UserSetting()
        }
        return UserSetting.singleton!
    }
    
    private static var singleton: UserSetting?
    private init() {
        general = GeneralSetting()
        
    }
}
