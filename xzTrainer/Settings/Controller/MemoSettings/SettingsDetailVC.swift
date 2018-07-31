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

    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var showInLetterSchemeSwitch: UISwitch!
    @IBOutlet weak var preferenceTable: UITableView!
    @IBOutlet weak var firstLetters: UILabel!
    
    var option: MemoOption!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        settingsTitle.text = option.description
        explanation.text = option.explanation
        priorityTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}

extension SettingsDetailVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension SettingsDetailVC: UITextFieldDelegate {
    
}
