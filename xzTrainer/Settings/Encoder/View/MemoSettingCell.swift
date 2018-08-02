//
//  MemoSettingCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/28/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class MemoSettingCell: ThemeCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var settingSwitch: ThemeSwitch!
    var managedMethod: MemoPreference!
    
    @IBAction func switchTriggered() {
        if settingSwitch.isOn {
            UserSetting.shared.encoder.activateSetting(managedMethod)
        } else {
            UserSetting.shared.encoder.deactivateSetting(managedMethod)
        }
    }
    
    func configureMemoSettingCell(method: MemoPreference, applicable: Bool) {
        let memoType = type(of: method)
        self.title.text = memoType.description
        managedMethod = method
        let memoKey = type(of: managedMethod).memoKey
        settingSwitch.isOn = UserDefaults.standard.object(forKey: memoKey) != nil && UserDefaults.standard.bool(forKey: memoKey)
        settingSwitch.isEnabled = applicable
        settingSwitch.isEnabled = !UserSetting.shared.encoder.userCustomizeOrder
    }

}

