//
//  EditSpecificLetterVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/9/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class EditSpecificLetterVC: UIViewController {

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
    
    var selectedEdgePiece: EdgePosition? = nil
    var selectedCornerPiece: CornerPosition? = nil
    
    var overwideTextFieldCount: Int = 0 {
        didSet {
            warningLabel.isHidden = overwideTextFieldCount == 0
        }
    }

    var isEdge: Bool {
        return selectedEdgePiece != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningLabel.isHidden = true
        
        assignDelegates()
        
        if isEdge {
            setUpForEdge()
        } else {
            setUpForCorner()
        }
        
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
    
    private func setUpForEdge() {
        piece2Label.isHidden = true
        piece2TextField.isHidden = true
        titleLabel.text = "Edge " + toString(selectedEdgePiece!)
        stickerLabel.text = toString(selectedEdgePiece!)
        stickerTextField.managedEdgePosition = selectedEdgePiece!
        
        let face3 = getNextPieceOnFaceAntiClockwise(selectedEdgePiece!)
        let face2 = getNextPieceOnFaceAntiClockwise(face3)
        let face1 = getNextPieceOnFaceAntiClockwise(face2)
        
        face1Label.text = toString(face1)
        face2Label.text = toString(face2)
        face3Label.text = toString(face3)
        
        face1TextField.managedEdgePosition = face1
        face2TextField.managedEdgePosition = face2
        face3TextField.managedEdgePosition = face3
        
        let piece1 = getAdjacentPosition(selectedEdgePiece!)
        piece1Label.text = toString(piece1)
        piece1TextField.managedEdgePosition = piece1
        
        bufferSwitch.isEnabled = !(UserSetting.shared.general.letterScheme[UserSetting.shared.general.edgeBuffer].count == 0) || selectedEdgePiece == UserSetting.shared.general.edgeBuffer
        
        // the switch is on if and only if the piece is buffer
        // and there is no label on it
        bufferSwitch.isOn = (UserSetting.shared.general.letterScheme[UserSetting.shared.general.edgeBuffer].count == 0) && selectedEdgePiece == UserSetting.shared.general.edgeBuffer
    }
    
    private func setUpForCorner() {
        titleLabel.text = "Corner " + toString(selectedCornerPiece!)
        stickerLabel.text = toString(selectedCornerPiece!)
        stickerTextField.managedCornerPosition = selectedCornerPiece!
        
        let face3 = getNextPieceOnFaceAntiClockwise(selectedCornerPiece!)
        let face2 = getNextPieceOnFaceAntiClockwise(face3)
        let face1 = getNextPieceOnFaceAntiClockwise(face2)
        
        face1Label.text = toString(face1)
        face2Label.text = toString(face2)
        face3Label.text = toString(face3)
        
        face1TextField.managedCornerPosition = face1
        face2TextField.managedCornerPosition = face2
        face3TextField.managedCornerPosition = face3
        
        let piece1 = getAdjacentPosition(selectedCornerPiece!)
        piece1Label.text = toString(piece1)
        piece1TextField.managedCornerPosition = piece1
        
        let piece2 = getAdjacentPosition(piece1)
        piece2Label.text = toString(piece2)
        piece2TextField.managedCornerPosition = piece2
        bufferSwitch.isEnabled = !(UserSetting.shared.general.letterScheme[UserSetting.shared.general.cornerBuffer].count == 0) || selectedCornerPiece == UserSetting.shared.general.cornerBuffer
        
        // the switch is on if and only if the piece is buffer
        // and there is no label on it
        bufferSwitch.isOn = (UserSetting.shared.general.letterScheme[UserSetting.shared.general.cornerBuffer].count == 0) && selectedCornerPiece == UserSetting.shared.general.cornerBuffer
        
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
            UserSetting.shared.general.edgeBuffer = selectedEdgePiece!
        } else {
            UserSetting.shared.general.cornerBuffer = selectedCornerPiece!
        }
    }
    
    func getNextPieceOnFaceAntiClockwise(_ piece: EdgePosition) -> EdgePosition {
        let cube = Cube()
        let string = toString(piece)
        cube.scrambleCube(String(string[...string.startIndex]))
        return cube[piece]
    }
    
    func getNextPieceOnFaceAntiClockwise(_ piece: CornerPosition) -> CornerPosition {
        let cube = Cube()
        let string = toString(piece)
        cube.scrambleCube(String(string[...string.startIndex]))
        return cube[piece]
    }
    
    private func getAdjacentPosition (_ sticker: EdgePosition)
        -> EdgePosition
    {
        let firstPart = sticker.rawValue / 2 * 2
        let secondPart = (sticker.rawValue + 1) % 2
        return  EdgeSticker(rawValue: firstPart + secondPart)!
    }
    
    private func getAdjacentPosition (_ sticker: CornerPosition)
        -> CornerPosition
    {
        let firstPart = sticker.rawValue / 3 * 3
        let secondPart = (sticker.rawValue + 1) % 3
        return  CornerSticker(rawValue: firstPart + secondPart)!
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
            
            if textField.managedCornerPosition != nil {
                UserSetting.shared.general.letterScheme[textField.managedCornerPosition!] = textField.text!
            } else {
                UserSetting.shared.general.letterScheme[textField.managedEdgePosition!] = textField.text!
            }
            
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
