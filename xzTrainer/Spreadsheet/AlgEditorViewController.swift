//
//  AlgEditorViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/6/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class AlgEditorViewController: ThemeViewController {

    var letterPairName: String!
    var storedAlgorithm: String!
    var storedAssociation: String!
    var onSavingNewAlg: ((String) -> ())?
    var onSavingNewAssociation: ((String) -> ())?
    @IBOutlet weak var titleLabel: ThemeHeader1!
    @IBOutlet weak var algEditor: AlgEditorView!
    @IBOutlet weak var algTextField: UITextField!
    @IBOutlet weak var assocTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = letterPairName
        algEditor.managedTextField = algTextField
        algEditor.entriesEntered = storedAlgorithm.split(separator: " ").map({String($0)})
        assocTextField.text = storedAssociation
        algTextField.delegate = self
        assocTextField.delegate = self
    }
}

extension AlgEditorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != algTextField {
            return
        }
        onSavingNewAlg?(textField.text!)
    }
    
    func checkAlg(_ alg: Algorithm) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        onSavingNewAssociation?(textField.text!)
        return true
    }
}
