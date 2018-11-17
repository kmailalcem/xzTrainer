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
        becomeObserver()
        themeSetUp()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func themeSetUp() {
        DispatchQueue.main.async {
            self.view.backgroundColor = Theme.current.backgroundColor
            self.view.tintColor = Theme.current.backgroundTintColor
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ThemeViewController.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
}
