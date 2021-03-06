//
//  AdvancedParityVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/24/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class AdvancedParityVC: ThemeViewController, UITextFieldDelegate {
    

    @IBOutlet weak var enableSwitch: ThemeSwitch!
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
        firstPieceTextField.text = UserSetting.shared.encoder.advancedParity.parityEdgePiece1.string
        secondPieceTextField.text = UserSetting.shared.encoder.advancedParity.parityEdgePiece2.string
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
        return EdgeSticker(rawValue: row)!.string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let edge = EdgeSticker(rawValue: row)!
        if pickerView == firstPiecePicker {
            firstPieceTextField.text = edge.string
            UserSetting.shared.encoder.advancedParity.parityEdgePiece1 = edge
        } else {
            secondPieceTextField.text = EdgeSticker(rawValue: row)!.string
            UserSetting.shared.encoder.advancedParity.parityEdgePiece2 = edge
        }
        
        warningLabel.isHidden = firstPieceTextField.text != secondPieceTextField.text
    }
}
