//
//  SettingsVCPicker.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/9/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

extension SettingsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == edgeBufferPickerView {
            let edge = EdgePosition(rawValue: row)!
            edgePickerTrigger.text = toString(edge)
            UserSetting.shared.general.edgeBuffer = edge
        } else if pickerView == cornerBufferPickerView {
            let corner = CornerPosition(rawValue: row)!
            cornerPickerTrigger.text = toString(corner)
            UserSetting.shared.general.cornerBuffer = corner
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
