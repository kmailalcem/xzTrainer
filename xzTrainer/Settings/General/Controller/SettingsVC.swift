//
//  SettingsVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/7/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SettingsVC:
    UIViewController,
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
        edgeBufferPickerView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        cornerBufferPickerView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        topColorPicker.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        frontColorPicker.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
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
        frontColorPickerTrigger.text = toString(frontColor)
        frontColorPickerTrigger.backgroundColor = UIColor(cgColor: colorScheme.scheme[frontColor]!)
        setTextFieldTextColor(for: frontColorPickerTrigger)
    }
    
    func updateTopTriggerUI() {
        let colorScheme = UserSetting.shared.general.colorScheme
        let topColor = UserSetting.shared.general.topFaceColor
        topColorPickerTrigger.text = toString(topColor)
        topColorPickerTrigger.backgroundColor = UIColor(cgColor: colorScheme.scheme[topColor]!)
        setTextFieldTextColor(for: topColorPickerTrigger)
    }
    
    func updateBufferTriggerUI() {
        edgePickerTrigger.text = toString(UserSetting.shared.general.edgeBuffer)
        cornerPickerTrigger.text = toString(UserSetting.shared.general.cornerBuffer)
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

func toString (_ edge: EdgePosition) -> String {
    switch edge {
    case .BD: return "BD"
    case .BL: return "BL"
    case .BR: return "BR"
    case .BU: return "BU"
    case .DB: return "DB"
    case .DF: return "DF"
    case .DL: return "DL"
    case .DR: return "DR"
    case .RB: return "RB"
    case .RD: return "RD"
    case .RF: return "RF"
    case .RU: return "RU"
    case .LB: return "LB"
    case .LF: return "LF"
    case .LU: return "LU"
    case .LD: return "LD"
    case .FD: return "FD"
    case .FU: return "FU"
    case .FL: return "FL"
    case .FR: return "FR"
    case .UB: return "UB"
    case .UF: return "UF"
    case .UL: return "UL"
    case .UR: return "UR"
    }
}

func toString (_ corner: CornerPosition) -> String {
    switch corner {
    case .UFL: return "UFL"
    case .FLU: return "FLU"
    case .LUF: return "LUF"
    case .ULB: return "ULB"
    case .LBU: return "LBU"
    case .BUL: return "BUL"
    case .UBR: return "UBR"
    case .BRU: return "BRU"
    case .RUB: return "RUB"
    case .URF: return "URF"
    case .RFU: return "RFU"
    case .FUR: return "FUR"
    case .DLF: return "DLF"
    case .LFD: return "LFD"
    case .FDL: return "FDL"
    case .DBL: return "DBL"
    case .BLD: return "BLD"
    case .LDB: return "LDB"
    case .DRB: return "DRB"
    case .RBD: return "RBD"
    case .BDR: return "BDR"
    case .DFR: return "DFR"
    case .FRD: return "FRD"
    case .RDF: return "RDF"
    }
}

func toString(_ color: CubeColor) -> String {
    switch color {
    case .WHITE:
        return "White"
    case .YELLOW:
        return "Yellow"
    case .GREEN:
        return "Green"
    case .BLUE:
        return "Blue"
    case .RED:
        return "Red"
    case .ORANGE:
        return "Orange"
    }
}
