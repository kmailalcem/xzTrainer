//
//  EditSpecificLetterVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/9/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class EditSpecificLetterVC: ThemeViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stickerLabel: UILabel!
    @IBOutlet weak var face1Label: UILabel!
    @IBOutlet weak var face2Label: UILabel!
    @IBOutlet weak var face3Label: UILabel!
    @IBOutlet weak var piece1Label: UILabel!
    @IBOutlet weak var piece2Label: UILabel!
    @IBOutlet weak var stickerTextField: LetterSetterTextField!
    @IBOutlet weak var face1TextField: LetterSetterTextField!
    @IBOutlet weak var face2TextField: LetterSetterTextField!
    @IBOutlet weak var face3TextField: LetterSetterTextField!
    @IBOutlet weak var piece1TextField: LetterSetterTextField!
    @IBOutlet weak var piece2TextField: LetterSetterTextField!
    @IBOutlet weak var bufferSwitch: ThemeSwitch!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet var samePieceStack: UIStackView!
    @IBOutlet var sameFaceStack: UIStackView!
    
    // To be hidden
    
    @IBOutlet var setAsBufferLabel: ThemeText!
    @IBOutlet var noteLabel: ThemeSubtext!
    @IBOutlet var samePieceLabel: UILabel!
    @IBOutlet var sameFaceLabel: UILabel!
    
    var selectedPiece: CubePiece!
    
    var isEdge: Bool {
        return selectedPiece is EdgeSticker
    }
    
    var overwideTextFieldCount: Int = 0 {
        didSet {
            warningLabel.isHidden = overwideTextFieldCount == 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningLabel.isHidden = true
        
        assignDelegates()
        
        setUpForPiece()
        
        stickerTextField.isEnabled = !bufferSwitch.isOn
        piece1TextField.isEnabled = !bufferSwitch.isOn
        piece2TextField.isEnabled = !bufferSwitch.isOn
    }
    
    private func assignDelegates() {
        stickerTextField.delegate = self
        face1TextField.delegate = self
        face2TextField.delegate = self
        face3TextField.delegate = self
        piece1TextField.delegate = self
        piece2TextField.delegate = self
    }
    
    private func setUpForPiece() {
        piece2Label.isHidden = isEdge
        piece2TextField.isHidden = isEdge
        titleLabel.text = type(of: selectedPiece).pieceName + " " + selectedPiece.string
        stickerLabel.text = selectedPiece.string
        stickerTextField.managedPiece = selectedPiece
        
        let face3 = getNextPieceOnFaceAntiClockwise(selectedPiece)
        let face2 = getNextPieceOnFaceAntiClockwise(face3)
        let face1 = getNextPieceOnFaceAntiClockwise(face2)
        
        face1Label.text = face1.string
        face2Label.text = face2.string
        face3Label.text = face3.string
        
        face1TextField.managedPiece = face1
        face2TextField.managedPiece = face2
        face3TextField.managedPiece = face3
        
        let piece1 = getAdjacentPosition(selectedPiece)
        piece1Label.text = piece1.string
        piece1TextField.managedPiece = piece1
        
        if !isEdge {
            let piece2 = getAdjacentPosition(piece1)
            piece2Label.text = piece2.string
            piece2TextField.managedPiece = piece2
        }
        
        if let edge = selectedPiece as? EdgeSticker {
            let edgeBuffer = UserSetting.shared.general.edgeBuffer
            bufferSwitch.isEnabled = !(UserSetting.shared.general.letterScheme[edgeBuffer].count == 0) || edge == edgeBuffer
            // the switch is on if and only if the piece is buffer
            // and there is no label on it
            bufferSwitch.isOn = (UserSetting.shared.general.letterScheme[edgeBuffer].count == 0) && edge == edgeBuffer
        } else if let corner = selectedPiece as? CornerSticker {
            let cornerBuffer = UserSetting.shared.general.cornerBuffer
            bufferSwitch.isEnabled = !(UserSetting.shared.general.letterScheme[corner].count == 0) || corner == cornerBuffer
            // the switch is on if and only if the piece is buffer
            // and there is no label on it
            bufferSwitch.isOn = (UserSetting.shared.general.letterScheme[cornerBuffer].count == 0) && corner == cornerBuffer
        }
    }
    
    @IBAction func toggleBufferSwitch(_ sender: UISwitch) {
        stickerTextField.isEnabled = !sender.isOn
        piece1TextField.isEnabled = !sender.isOn
        piece2TextField.isEnabled = !sender.isOn
        
        // turned back off to allow individual lettering
        if !sender.isOn {
            stickerTextField.text = "?"
            piece1TextField.text = "?"
            piece2TextField.text = "?"
        }
        
        if isEdge {
            UserSetting.shared.general.edgeBuffer = selectedPiece as! EdgeSticker
        } else {
            UserSetting.shared.general.cornerBuffer = selectedPiece as! CornerSticker
        }
    }
    
    func getNextPieceOnFaceAntiClockwise(_ piece: CubePiece) -> CubePiece {
        let cube = Cube()
        let string = piece.string
        cube.scrambleCube(String(string[...string.startIndex]))
        return cube[piece]
    }
    
    private func getAdjacentPosition (_ sticker: CubePiece) -> CubePiece {
        let faceCount = type(of: sticker).faceCount
        let firstPart = sticker.rawValue / faceCount * faceCount
        let secondPart = (sticker.rawValue + 1) % faceCount
        return  type(of: sticker).init(rawValue: firstPart + secondPart)!
    }
}

extension EditSpecificLetterVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? LetterSetterTextField {
            if textField.text?.count == 0 {
                textField.text = "Unlabeled"
            }
            
            if textField.text != "Unlabeled" {
                if (textField.text?.count)! > 3 && !textField.isOverwide {
                    textField.isOverwide = true
                    overwideTextFieldCount += 1
                } else if (textField.text?.count)! <= 3 && textField.isOverwide {
                    textField.isOverwide = false
                    overwideTextFieldCount -= 1
                }
            }
            
            UserSetting.shared.general.letterScheme[textField.managedPiece] = textField.text!
            
        }
        
        textField.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let textField = textField as? LetterSetterTextField {
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        }
    }
}
