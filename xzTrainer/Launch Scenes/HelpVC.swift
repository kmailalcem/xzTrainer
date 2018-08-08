//
//  HelpVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/8/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToWiki() {
        openUrl("https://github.com/kmailalcem/xzTrainer/wiki")
    }
}
