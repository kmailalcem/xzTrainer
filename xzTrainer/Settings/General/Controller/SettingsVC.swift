//
//  SettingsVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/7/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SettingsVC:
    ThemeViewController,
    UITextFieldDelegate
{
    
    let edgeBufferPickerView = UIPickerView()
    let cornerBufferPickerView = UIPickerView()
    let topColorPicker = UIPickerView()
    let frontColorPicker = UIPickerView()
    @IBOutlet weak var edgePickerTrigger: UITextField!
    @IBOutlet weak var cornerPickerTrigger: UITextField!
    @IBOutlet weak var topColorPickerTrigger: UITextField!
    @IBOutlet weak var frontColorPickerTrigger: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var wcaSwitch: ThemeSwitch!
    
    var availableTopColor = CubeColor.allValues
    var availableFrontColor = CubeColor.allValues
    
    @IBAction func dismissPicker() {
        resignAll()
        dismissButton.alpha = 0
    }
    
    @IBAction func toggleScrambleOrientation() {
        UserSetting.shared.encoder.scrambleInWCAOrientation = wcaSwitch.isOn
    }
    private func resignAll() {
        edgePickerTrigger.resignFirstResponder()
        cornerPickerTrigger.resignFirstResponder()
        frontColorPickerTrigger.resignFirstResponder()
        topColorPickerTrigger.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegates()
        assignDataSources()
        setUpBackgroundColors()
        setUpInputViews()
        updateTopTriggerUI()
        updateFrontTriggerUI()
        updateBufferTriggerUI()
        eliminateInvalidTopColors()
        eliminateInvalidFrontColors()
        
        dismissButton.alpha = 0
        wcaSwitch.isOn = UserSetting.shared.encoder.scrambleInWCAOrientation
    }

    
    func setUpInputViews() {
        cornerPickerTrigger.inputView = cornerBufferPickerView
        edgePickerTrigger.inputView = edgeBufferPickerView
        topColorPickerTrigger.inputView = topColorPicker
        frontColorPickerTrigger.inputView = frontColorPicker
    }
    
    func assignDelegates() {
        edgeBufferPickerView.delegate = self
        cornerBufferPickerView.delegate = self
        topColorPicker.delegate = self
        frontColorPicker.delegate = self
        cornerPickerTrigger.delegate = self
        edgePickerTrigger.delegate = self
        frontColorPickerTrigger.delegate = self
        topColorPickerTrigger.delegate = self
    }
    
    func assignDataSources() {
        edgeBufferPickerView.dataSource = self
        cornerBufferPickerView.dataSource = self
        topColorPicker.dataSource = self
        topColorPicker.dataSource = self
    }
    
    func setUpBackgroundColors() {
        edgeBufferPickerView.backgroundColor = Theme.current.backgroundColor
        cornerBufferPickerView.backgroundColor = Theme.current.backgroundColor
        topColorPicker.backgroundColor = Theme.current.backgroundColor
        frontColorPicker.backgroundColor = Theme.current.backgroundColor
    }
    
    func eliminateInvalidTopColors() {
        let frontColor = UserSetting.shared.general.frontFaceColor
        availableTopColor = CubeColor.allValues
        availableTopColor.remove(at: availableTopColor.index(of: frontColor)!)
        availableTopColor.remove(at: availableTopColor.index(of: oppositeColor(frontColor))!)
    }
    
    func eliminateInvalidFrontColors() {
        let topColor = UserSetting.shared.general.topFaceColor
        availableFrontColor = CubeColor.allValues
        availableFrontColor.remove(at: availableFrontColor.index(of: topColor)!)
        availableFrontColor.remove(at: availableFrontColor.index(of: oppositeColor(topColor))!)
    }
    
    func updateFrontTriggerUI() {
        let colorScheme = UserSetting.shared.general.colorScheme
        let frontColor = UserSetting.shared.general.frontFaceColor
        frontColorPickerTrigger.text = frontColor.string
        frontColorPickerTrigger.backgroundColor = UIColor(cgColor: colorScheme.scheme[frontColor]!)
        setTextFieldTextColor(for: frontColorPickerTrigger)
    }
    
    func updateTopTriggerUI() {
        let colorScheme = UserSetting.shared.general.colorScheme
        let topColor = UserSetting.shared.general.topFaceColor
        topColorPickerTrigger.text = topColor.string
        topColorPickerTrigger.backgroundColor = UIColor(cgColor: colorScheme.scheme[topColor]!)
        setTextFieldTextColor(for: topColorPickerTrigger)
    }
    
    func updateBufferTriggerUI() {
        edgePickerTrigger.text = UserSetting.shared.general.edgeBuffer.string
        cornerPickerTrigger.text = UserSetting.shared.general.cornerBuffer.string
        edgePickerTrigger.isEnabled = !(UserSetting.shared.general.letterScheme[UserSetting.shared.general.edgeBuffer].count == 0) && !UserSetting.shared.encoder.userCustomizeOrder
        cornerPickerTrigger.isEnabled = !(UserSetting.shared.general.letterScheme[UserSetting.shared.general.cornerBuffer].count == 0) && !UserSetting.shared.encoder.userCustomizeOrder
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissButton.alpha = 1
    }
    
    func setTextFieldTextColor(for textField: UITextField) {
        let bgColor = textField.backgroundColor!
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1
        bgColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        
        if brightness < 0.5 {
            textField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        updateBufferTriggerUI()
    }
    
}

