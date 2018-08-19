//
//  EditLetterSchemeVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/7/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class EditLetterSchemeVC: ThemeViewController {
    
    @IBOutlet weak var leftFace: UIView!
    @IBOutlet weak var rightFace: UIView!
    @IBOutlet weak var backFace: UIView!
    @IBOutlet weak var frontFace: UIView!
    @IBOutlet weak var topFace: UIView!
    @IBOutlet weak var bottomFace: UIView!
    
    var isWideEnoughForHorizontalEditing: Bool {
        return UIDevice.current.orientation.isLandscape || UIDevice.current.model == "iPad"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorScheme = UserSetting.shared.general.colorScheme
        let topColor = UserSetting.shared.general.topFaceColor
        let frontColor = UserSetting.shared.general.frontFaceColor
        topFace.backgroundColor = UIColor(cgColor: colorScheme.scheme[topColor]!)
        frontFace.backgroundColor = UIColor(cgColor: colorScheme.scheme[frontColor]!)
        leftFace.backgroundColor = UIColor(cgColor:
            colorScheme.scheme[leftSideColor(top: topColor, front: frontColor)]!)
        rightFace.backgroundColor = UIColor(cgColor: colorScheme.scheme[rightSideColor(top: topColor, front: frontColor)]!)
        bottomFace.backgroundColor = UIColor(cgColor:
            colorScheme.scheme[oppositeColor(topColor)]!)
        backFace.backgroundColor = UIColor(cgColor:
            colorScheme.scheme[oppositeColor(frontColor)]!)
        
        
        if isWideEnoughForHorizontalEditing {
            for view in [leftFace, rightFace, backFace, frontFace, topFace, bottomFace] {
                view?.transform = CGAffineTransform.init(rotationAngle: -.pi / 2)
            }
        }
        updateLetterScheme()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if isWideEnoughForHorizontalEditing {
            for view in [leftFace, rightFace, backFace, frontFace, topFace, bottomFace] {
                view?.transform = CGAffineTransform.init(rotationAngle: -.pi / 2)
            }
        } else {
            for view in [leftFace, rightFace, backFace, frontFace, topFace, bottomFace] {
                view?.transform = .identity
            }
        }
        updateLetterScheme()
    }
    
    private func updateLetterScheme() {
        for i in 0 ..< NUM_STICKERS {
            configureEdgeButton(WithCorrespondingRawValue: i)
            configureCornerButton(WithCorrespondingRawValue: i)
        }
    }
    
    private func configureEdgeButton(WithCorrespondingRawValue i: Int) {
        let letterScheme = UserSetting.shared.general.letterScheme
        let edgeButton = view.viewWithTag(i + 1) as! UIButton
        let edgeLetter = letterScheme[EdgePosition(rawValue: i)!]
        if edgeLetter == "Unlabeled" {
            edgeButton.setTitle("UNL", for: .normal)
        } else {
            edgeButton.setTitle(edgeLetter, for: .normal)
        }
        setButtonTextColor(for: edgeButton)
        if isWideEnoughForHorizontalEditing {
            edgeButton.transform = CGAffineTransform.init(rotationAngle: .pi / 2)
        } else {
            edgeButton.transform = .identity
        }
    }
    
    private func configureCornerButton(WithCorrespondingRawValue i: Int) {
        let letterScheme = UserSetting.shared.general.letterScheme
        let cornerButton = view.viewWithTag(i + 1 + NUM_STICKERS) as! UIButton
        let cornerLetter = letterScheme[CornerPosition(rawValue: i)!]
        if cornerLetter == "Unlabeled" {
            cornerButton.setTitle("UNL", for: .normal)
        } else {
            cornerButton.setTitle(cornerLetter, for: .normal)
        }
        setButtonTextColor(for: cornerButton)
        if isWideEnoughForHorizontalEditing {
            cornerButton.transform = CGAffineTransform.init(rotationAngle: .pi / 2)
        } else {
            cornerButton.transform = .identity
        }
    }
    
    private func setButtonTextColor(for button: UIButton) {
        let bgColor = button.superview!.backgroundColor!
        var red: CGFloat = 1, green: CGFloat = 1, blue: CGFloat = 1
        bgColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        
        if brightness < 0.5 {
            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        } else {
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
    }

    
    @IBAction func useTraditional() {
        let alert = ThemeAlertController(title: "Are you sure?", message: "This will wipe out your current letter scheme.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Change to Traditional", style: .default, handler: { (_) in
            UserSetting.shared.general.letterScheme.useTraditional()
            self.updateLetterScheme()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func useSpeffz() {
        let alert = ThemeAlertController(title: "Are you sure?", message: "This will wipe out your current letter scheme.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Change to Speffz", style: .default, handler: { (_) in
            UserSetting.shared.general.letterScheme.useSpeffz()
            self.updateLetterScheme()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    @IBAction func selectPiece(_ sender: UIButton) {
        // sender is an edge piece
        if sender.tag < NUM_STICKERS + 1 {
            performSegue(withIdentifier: "toSpecificLetter", sender: EdgePosition(rawValue: sender.tag - 1)!)
        } else { // sender is a corner piece
            performSegue(withIdentifier: "toSpecificLetter", sender: CornerPosition(rawValue: sender.tag - 1 - NUM_STICKERS)!)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditSpecificLetterVC {
            if sender is EdgeSticker {
                destination.selectedPiece = sender as! EdgeSticker
            } else {
                destination.selectedPiece = sender as! CornerSticker
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        if let destination = segue.destination as? EditLetterSchemeVC {
            if let source = segue.source as? EditSpecificLetterVC {
                source.face1TextField.resignFirstResponder()
                source.face2TextField.resignFirstResponder()
                source.face3TextField.resignFirstResponder()
                source.piece1TextField.resignFirstResponder()
                source.piece2TextField.resignFirstResponder()
                source.stickerTextField.resignFirstResponder()
                if source.bufferSwitch.isOn {
                    UserSetting.shared.general.letterScheme[source.stickerTextField.managedPiece] = ""
                    UserSetting.shared.general.letterScheme[source.piece1TextField.managedPiece] = ""
                    if !source.isEdge {
                        
                        UserSetting.shared.general.letterScheme[source.piece2TextField.managedPiece] = ""
                    }
                }
            }
            destination.updateLetterScheme()
        }
    }

}
