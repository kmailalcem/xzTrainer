//
//  DoneTextField.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/27/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class DoneTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DoneTextField.doneClicked))
        toolBar.setItems([doneButton], animated: true)
        inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        endEditing(true)
    }
}
