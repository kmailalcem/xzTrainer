//
//  TimerVCFAB.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/27/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

// manages floating action button
extension TimerVC {
    
    @IBAction func floatingPlusPressed (_ sender: UIButton) {
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
        dismissPopUpButton.alpha = 1
        view.insertSubview(dismissPopUpButton, aboveSubview: timerLabel)
        inTimerSettingButton.transform = .identity
        nextScrambleButton.transform = .identity
        manuallyEnterTimeButton.transform = .identity
        floatingPlus.transform = CGAffineTransform(rotationAngle: 3 * .pi / 4)
        floatingPlusIsPressed = true
    }
    
    @IBAction func manualButtonPressed() {
        if memoIsShown || isCasual {
            let alert = ThemeAlertController(title: "Manually Enter Time", message: "", preferredStyle: .alert)
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
        } else {
            showMemo()
            memoIsShown = true
            cubeView.showAllFaces()
            DispatchQueue.main.async {
                self.manuallyEnterTimeButton.imageView?.image = #imageLiteral(resourceName: "ManuallyEnterTime")
            }
        }
    
    }
    
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
