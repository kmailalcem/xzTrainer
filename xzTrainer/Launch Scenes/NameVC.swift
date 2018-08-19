//
//  NameVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 8/2/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class NameVC: ThemeViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        if textField.text == nil || textField.text!.count == 0 {
            textField.text = "A Passionate Cuber"
        }
        UserSetting.shared.general.name = textField.text!
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = UserSetting.shared.general.name
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }

}
