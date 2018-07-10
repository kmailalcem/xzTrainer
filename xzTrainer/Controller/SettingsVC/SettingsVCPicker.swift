//
//  SettingsVCPicker.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/9/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

extension SettingsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == edgeBufferPickerView {
            edgePickerTrigger.text = toString(EdgePosition(rawValue: row)!)
        } else if pickerView == cornerBufferPickerView {
            cornerPickerTrigger.text = toString(CornerPosition(rawValue: row)!)
        } else if pickerView == topColorPicker {
            UserSetting.shared.general.topFaceColor = availableTopColor[row]
            eliminateInvalidFrontColors()
            updateTopTriggerUI()
        } else if pickerView == frontColorPicker {
            UserSetting.shared.general.frontFaceColor = availableFrontColor[row]
            eliminateInvalidTopColors()
            updateFrontTriggerUI()
        }
    }
}

extension SettingsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == edgeBufferPickerView || pickerView == cornerBufferPickerView {
            return NUM_STICKERS
        } else {
            return 4
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == edgeBufferPickerView {
            return toString(EdgePosition(rawValue: row)!)
        }  else if pickerView == cornerBufferPickerView {
            return toString(CornerPosition(rawValue: row)!)
        } else if pickerView == frontColorPicker {
            return toString(availableFrontColor[row])
        } else if pickerView == topColorPicker {
            return toString(availableTopColor[row])
        }
        return "white"
    }
    
    
}
