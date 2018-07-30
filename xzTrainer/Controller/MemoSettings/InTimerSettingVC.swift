//
//  InTimerSettingVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/27/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
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
            if let sender = sender as? MemoOption {
                destination.option = sender
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
