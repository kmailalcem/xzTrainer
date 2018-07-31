//
//  MemoSettingCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/28/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class MemoSettingCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    var managedMethod: MemoPreference!
    
    @IBAction func switchTriggered() {
        if settingSwitch.isOn {
            UserSetting.shared.encoder.activateSetting(managedMethod)
        } else {
            UserSetting.shared.encoder.deactivateSetting(managedMethod)
        }
    }
    
    func configureMemoSettingCell(title: String, method: MemoPreference) {
        self.title.text = title
        managedMethod = method
        settingSwitch.onTintColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
        settingSwitch.tintColor = #colorLiteral(red: 0.6352941176, green: 0.7803921569, blue: 0.9882352941, alpha: 1)
        let memoKey = type(of: managedMethod).memoKey
        settingSwitch.isOn = UserDefaults.standard.object(forKey: memoKey) != nil && UserDefaults.standard.bool(forKey: memoKey)
    }

}

