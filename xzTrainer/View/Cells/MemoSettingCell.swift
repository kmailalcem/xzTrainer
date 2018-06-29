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
    var switchHandler: ((Bool) -> Void)? = nil
    
    @IBAction func switchTriggered() {
        switchHandler?(settingSwitch.isOn)
    }
    
    func configureMemoSettingCell(title: String, handler: @escaping (Bool) -> Void) {
        self.title.text = title
        switchHandler = handler
        settingSwitch.onTintColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
        settingSwitch.tintColor = #colorLiteral(red: 0.6352941176, green: 0.7803921569, blue: 0.9882352941, alpha: 1)
    }

}

