//
//  SettingsDetailVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/29/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

func formatedPieces(_ pieces: [EdgeSticker], showInLetters: Bool) -> String {
    var result = ""
    var separated = false
    for piece in pieces {
        if separated {
            result += ", "
        }
        separated = true
        if showInLetters {
            result += UserSetting.shared.general.letterScheme.edgeScheme[piece]!
        } else {
            result += toString(piece)
        }
    }
    return result
}

func formatedPieces(_ pieces: [CornerSticker], showInLetters: Bool) -> String {
    var result = ""
    var separated = false
    for piece in pieces {
        if separated {
            result += ", "
        }
        separated = true
        if showInLetters {
            result += UserSetting.shared.general.letterScheme.cornerScheme[piece]!
        } else {
            result += toString(piece)
        }
    }
    return result
}

class SettingsDetailVC: UIViewController {
    
    @IBOutlet weak var settingsTitle: UILabel!
    @IBOutlet weak var explanation: UITextView!

    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var showInLetterSchemeSwitch: ThemeSwitch!
    @IBOutlet weak var preferenceTable: UITableView!
    @IBOutlet weak var firstLetters: UILabel!
    
    @IBOutlet weak var nACover: UIView!
    @IBOutlet weak var nAMessage: UILabel!
    
    @IBOutlet weak var firstLettersView: UIView!
    var option: MemoPreference!
    var applicable: Bool!
    var secondEdgeLetters = [(EdgeSticker, [EdgeSticker])]()
    var secondCornerLetters = [(CornerSticker, [CornerSticker])]()
    
    private var methodIsEdge: Bool {
        return option.isEdgeMethod
    }
    
    private var isPreferMethod: Bool {
        return option.isPreferringMethod
    }
    
    private var methodDescription: String {
        return type(of: option).description
    }
    
    private var methodExplanation: String {
        return type(of: option).explanation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        settingsTitle.text = methodDescription
        explanation.text = methodExplanation
        priorityTextField.delegate = self
        preferenceTable.delegate = self
        preferenceTable.dataSource = self
        
        priorityTextField.text = String(option.priority)
        
        
        if applicable {
            nACover.alpha = 0
        } else {
            showInLetterSchemeSwitch.isOn = false
            showInLetterSchemeSwitch.isEnabled = false
            nAMessage.text = "This method does not apply to your choice of \(methodIsEdge ? "edge" : "corner") buffer."
        }
        loadSecondLetters()
        updateLetters()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func setPriority() {
        if let priorityString = priorityTextField.text {
            if var priority = Int(priorityString) {
                if priority > 100 {
                    priority = 100
                } else if priority < 0 {
                    priority = 0
                }

                priorityTextField.text = String(priority)
                print(priority)
            }
        }
        priorityTextField.resignFirstResponder()
    }
    
    @IBAction func updateLetters() {
        if isPreferMethod {
            if  methodIsEdge {
                firstLetters.text = formatedPieces(option.preferredFirstEdge, showInLetters: showInLetterSchemeSwitch.isOn)
            } else {
                firstLetters.text = formatedPieces(option.preferredFirstCorner, showInLetters: showInLetterSchemeSwitch.isOn)
            }
        } else {
            if methodIsEdge {
                firstLetters.text = formatedPieces(option.avoidedFirstEdge, showInLetters: showInLetterSchemeSwitch.isOn)
            } else {
                firstLetters.text = formatedPieces(option.avoidedFirstCorner, showInLetters: showInLetterSchemeSwitch.isOn)
            }
            firstLetters.textColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
        }
        if firstLetters.text?.count == 0 {
            firstLettersView.removeConstraints(firstLettersView.constraints)
            firstLettersView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            firstLettersView.isHidden = true
        }
        preferenceTable.reloadData()
    }

    func loadSecondLetters() {
        if isPreferMethod {
            if  methodIsEdge {
                for i in 0 ..< NUM_STICKERS {
                    let edge = EdgeSticker(rawValue: i)!
                    let preferredEdges = option.preferredSecondEdge(for: edge)
                    if preferredEdges.count > 0 {
                        secondEdgeLetters.append((edge, preferredEdges))
                    }
                }
            } else {
                for i in 0 ..< NUM_STICKERS {
                    let corner = CornerSticker(rawValue: i)!
                    let preferredCorners = option.preferredSecondCorner(for: corner)
                    if preferredCorners.count > 0 {
                        secondCornerLetters.append((corner, preferredCorners))
                    }
                }
            }
        } else {
            if methodIsEdge {
                for i in 0 ..< NUM_STICKERS {
                    let edge = EdgeSticker(rawValue: i)!
                    let avoidedEdges = option.avoidedSecondEdge(for: edge)
                    if avoidedEdges.count > 0 {
                        secondEdgeLetters.append((edge, avoidedEdges))
                    }
                }
            } else {
                for i in 0 ..< NUM_STICKERS {
                    let corner = CornerSticker(rawValue: i)!
                    let avoidedCorners = option.avoidedSecondCorner(for: corner)
                    if avoidedCorners.count > 0 {
                       secondCornerLetters.append((corner, avoidedCorners))
                    }
                }
            }
            firstLetters.textColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
        }
    }
}

extension SettingsDetailVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(secondCornerLetters.count, secondEdgeLetters.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferenceCell") as! PreferenceCell
        if methodIsEdge {
            let (edge, secondLetters) = secondEdgeLetters[indexPath.row]
            cell.configureCell(
                startingLetter: formatedPieces([edge], showInLetters: showInLetterSchemeSwitch.isOn),
                secondLetters: formatedPieces(secondLetters, showInLetters: showInLetterSchemeSwitch.isOn),
                isPreferringMethod: isPreferMethod)
            return cell
        } else {
            let (corner, secondLetters) = secondCornerLetters[indexPath.row]
            cell.configureCell(
                startingLetter: formatedPieces([corner], showInLetters: showInLetterSchemeSwitch.isOn),
                secondLetters: formatedPieces(secondLetters, showInLetters: showInLetterSchemeSwitch.isOn),
                isPreferringMethod: isPreferMethod)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension SettingsDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let priorityString = textField.text {
            if let priority = Int(priorityString) {
                print(priority)
            }
        }
        textField.resignFirstResponder()
        return false
    }
}
