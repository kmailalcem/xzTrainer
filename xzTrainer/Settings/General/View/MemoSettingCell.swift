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
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.937254902, alpha: 1)
        } else {
            contentView.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
        }
    }

}

