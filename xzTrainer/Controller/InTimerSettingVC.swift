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
    @IBOutlet weak var settingsTable: UITableView!
    var memoSettingsDataSource: MemoSettingsDataSource = MemoSettingsDataSource()
    
    override func viewDidLoad() {
        backButton.transform = CGAffineTransform(rotationAngle: .pi)
        settingsTable.delegate = self
        settingsTable.dataSource = memoSettingsDataSource
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
}

extension InTimerSettingVC: UITableViewDelegate {
    
}
