//
//  SettingsDetailVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/29/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class SettingsDetailVC: UIViewController {
    
    @IBOutlet weak var settingsTitle: UILabel!
    @IBOutlet weak var explanation: UITextView!

    var option: MemoOption!
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        settingsTitle.text = option.description
        explanation.text = option.explanation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
