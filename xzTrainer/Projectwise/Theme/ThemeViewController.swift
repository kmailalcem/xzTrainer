//
//  ThemeViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/19/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.current.backgroundColor
        view.tintColor = Theme.current.backgroundTintColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
