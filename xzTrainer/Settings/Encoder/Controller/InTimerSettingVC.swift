//
//  InTimerSettingVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/27/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class InTimerSettingVC: ThemeViewController {
    @IBOutlet weak var backButton: UIButtonX!
    @IBOutlet weak var settingsTable: SettingsTableView!
    @IBOutlet weak var wcaSwitch: ThemeSwitch!
    @IBAction func toggleScrambleOrientation() {
        UserSetting.shared.encoder.scrambleInWCAOrientation = wcaSwitch.isOn
    }
    
    var memoSettingsDataSource: MemoSettingsDataSource = MemoSettingsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTable.delegate = memoSettingsDataSource
        settingsTable.dataSource = memoSettingsDataSource
        settingsTable.containerViewController = self
        wcaSwitch.isOn = UserSetting.shared.encoder.scrambleInWCAOrientation
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SettingsDetailVC {
            if let sender = sender as? MemoSettingCell {
                destination.option = sender.managedMethod
                destination.applicable = sender.settingSwitch.isEnabled
            }
        }
    }
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        settingsTable.reloadData()
    }
}
