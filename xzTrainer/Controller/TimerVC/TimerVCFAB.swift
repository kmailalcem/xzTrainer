//
//  TimerVCFAB.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/27/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

// manages floating action button
extension TimerVC {
    
    @IBAction func floatingPlusPressed (_ sender: UIButton) {
        if !resultTableIsShown {
            if floatingPlus.transform == .identity {
                
                UIView.animate(withDuration: 0.2) {
                    self.showFABs()
                }
                floatingPlus.isSelected = true
            } else {
                
                UIView.animate(withDuration: 0.15) {
                    self.hideFABs()
                }
                floatingPlus.isSelected = false
            }
        } else {
            
            let alert = UIAlertController(title: "New Session", message: "Please name your new session: ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
                var sessionName = alert.textFields?.first?.placeholder
                if alert.textFields?.first?.text! != "" {
                    sessionName = alert.textFields?.first?.text
                }
                let session = self.data.requestSession()
                session.name = sessionName
                session.id = Int32(Date().timeIntervalSince1970)
                self.data.append(session: session)
                self.sessionTable.reloadData()
            }))
            alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
            alert.addTextField { (textField) in
                textField.placeholder = Date().description
            }
            present(alert, animated: true)
        }
    }
    
    func hideFABs() {
        dismissPopUpButton.alpha = 0
        inTimerSettingButton.transform = CGAffineTransform(translationX: 0, y: 78)
        nextScrambleButton.transform = CGAffineTransform(translationX: 0, y: 133)
        manuallyEnterTimeButton.transform = CGAffineTransform(translationX: 0, y: 188)
        floatingPlus.transform = .identity
        floatingPlusIsPressed = false
    }
    
    func showFABs() {
        dismissPopUpButton.alpha = 0.05
        view.insertSubview(dismissPopUpButton, aboveSubview: timerLabel)
        inTimerSettingButton.transform = .identity
        nextScrambleButton.transform = .identity
        manuallyEnterTimeButton.transform = .identity
        floatingPlus.transform = CGAffineTransform(rotationAngle: 3 * .pi / 4)
        floatingPlusIsPressed = true
    }
    
    @IBAction func manualButtonPressed() {
        let alert = UIAlertController(title: "Manually Enter Time", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            if let timeString = alert.textFields?.first?.text {
                if let time = self.parseTimeString(timeString) {
                    self.timerLabel.manuallyEntered(time: time)
                    self.timerDidFinish(self.timerLabel)
                }
            }
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your time"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        present(alert, animated: true)
    }
    
    // TODO: Bug, 0.075 becomes 0.750
    private func parseTimeString(_ timeString: String) -> Double? {
        var components = timeString.split(whereSeparator: { (c) -> Bool in
            return c == ":" || c == "."
        })
        if components.count != 2 && components.count != 3 { return nil }
        if components.count == 2 { components.insert("0", at: 0) }
        let minutes = Int(String(components[0]))
        let seconds = Int(String(components[1]))
        let miliseconds = Double("0." + String(components[2]))
        if minutes == nil || seconds == nil || miliseconds == nil {
            return nil
        }
        
        return Double(minutes! * 60 + seconds!) + miliseconds!
    }
    
}
