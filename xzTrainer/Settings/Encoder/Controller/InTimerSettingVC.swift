//
//  InTimerSettingVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/27/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class InTimerSettingVC: UIViewController {
    @IBOutlet weak var backButton: UIButtonX!
    @IBOutlet weak var settingsTable: SettingsTableView!
    var memoSettingsDataSource: MemoSettingsDataSource = MemoSettingsDataSource()
    
    override func viewDidLoad() {
        settingsTable.delegate = memoSettingsDataSource
        settingsTable.dataSource = memoSettingsDataSource
        settingsTable.containerViewController = self
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
