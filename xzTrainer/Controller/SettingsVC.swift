//
//  SettingsVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/7/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class SettingsVC:
    UIViewController,
    UIPickerViewDataSource,
    UIPickerViewDelegate,
    UITextFieldDelegate
{
    
    let edgeBufferPickerView = UIPickerView()
    let cornerBufferPickerView = UIPickerView()
    @IBOutlet weak var edgePickerTrigger: UITextField!
    @IBOutlet weak var cornerPickerTrigger: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    var isSettingEdge: Bool = false
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NUM_STICKERS
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == edgeBufferPickerView ? toString(EdgePosition(rawValue: row)!) : toString(CornerPosition(rawValue: row)!)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == edgeBufferPickerView {
            edgePickerTrigger.text = toString(EdgePosition(rawValue: row)!)
        } else {
            cornerPickerTrigger.text = toString(CornerPosition(rawValue: row)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        edgeBufferPickerView.delegate = self
        edgeBufferPickerView.dataSource = self
        edgeBufferPickerView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        cornerBufferPickerView.delegate = self
        cornerBufferPickerView.dataSource = self
        cornerBufferPickerView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7882352941, blue: 0.8470588235, alpha: 1)
        
        cornerPickerTrigger.inputView = cornerBufferPickerView
        edgePickerTrigger.inputView = edgeBufferPickerView
        cornerPickerTrigger.delegate = self
        edgePickerTrigger.delegate = self
        
        dismissButton.alpha = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissButton.alpha = 1
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissPicker() {
        edgePickerTrigger.resignFirstResponder()
        cornerPickerTrigger.resignFirstResponder()
        dismissButton.alpha = 0
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
