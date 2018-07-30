//
//  AdvancedParityVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/24/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class AdvancedParityVC: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var enableSwitch: UISwitch!
    @IBOutlet weak var firstPieceTextField: DropDownTextField!
    @IBOutlet weak var secondPieceTextField: DropDownTextField!
    @IBOutlet weak var dismissPickerButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    
    let firstPiecePicker = UIPickerView()
    let secondPiecePiecker = UIPickerView()
    
    @IBAction func dismissPicker() {
        dismissPickerButton.alpha = 0
        firstPieceTextField.resignFirstResponder()
        secondPieceTextField.resignFirstResponder()
    }
    
    @IBAction func advancedParityToggle() {
        UserSetting.shared.encoder.advancedParity.isEnabled = enableSwitch.isOn
        firstPieceTextField.isEnabled = enableSwitch.isOn
        secondPieceTextField.isEnabled = enableSwitch.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableSwitch.onTintColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
        enableSwitch.tintColor = #colorLiteral(red: 0.6352941176, green: 0.7803921569, blue: 0.9882352941, alpha: 1)
        
        firstPiecePicker.delegate = self
        secondPiecePiecker.delegate = self
        firstPiecePicker.dataSource = self
        secondPiecePiecker.dataSource = self
        
        firstPieceTextField.inputView = firstPiecePicker
        secondPieceTextField.inputView = secondPiecePiecker
        firstPieceTextField.delegate = self
        secondPieceTextField.delegate = self
        
        firstPiecePicker.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        secondPiecePiecker.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        dismissPickerButton.alpha = 0
        
        enableSwitch.isOn = UserSetting.shared.encoder.advancedParity.isEnabled
        firstPieceTextField.text = toString(UserSetting.shared.encoder.advancedParity.parityEdgePiece1)
        secondPieceTextField.text = toString(UserSetting.shared.encoder.advancedParity.parityEdgePiece2)
        warningLabel.isHidden = firstPieceTextField.text != secondPieceTextField.text
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissPickerButton.alpha = 1
    }
}

extension AdvancedParityVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NUM_STICKERS
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return toString(EdgeSticker(rawValue: row)!)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let edge = EdgeSticker(rawValue: row)!
        if pickerView == firstPiecePicker {
            firstPieceTextField.text = toString(edge)
            UserSetting.shared.encoder.advancedParity.parityEdgePiece1 = edge
        } else {
            secondPieceTextField.text = toString(EdgeSticker(rawValue: row)!)
            UserSetting.shared.encoder.advancedParity.parityEdgePiece2 = edge
        }
        
        warningLabel.isHidden = firstPieceTextField.text != secondPieceTextField.text
    }
}
