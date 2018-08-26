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
    @IBAction func floatingPlusPressed () {
        if floatingPlus.transform == .identity {
            UIView.animate(withDuration: 0.2) {
                self.showFABs()
            }
            floatingPlus.isSelected = true
        } else {
            UIView.animate(withDuration: 0.2) {
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
    }
    
    func showFABs() {
        dismissPopUpButton.alpha = 1
        view.insertSubview(dismissPopUpButton, aboveSubview: timerLabel)
        inTimerSettingButton.transform = .identity
        nextScrambleButton.transform = .identity
        manuallyEnterTimeButton.transform = .identity
        floatingPlus.transform = CGAffineTransform(rotationAngle: 3 * .pi / 4)
    }
    
   
    
    @IBAction func manualButtonPressed() {
        if shouldManuallyEnterTime {
            presentManualAlert()
        } else {
            detailCubeView.memoDisplayMode = .shown
            DispatchQueue.main.async {
                self.manuallyEnterTimeButton.imageView?.image = #imageLiteral(resourceName: "ManuallyEnterTime")
            }
        }
    }
    
    private var shouldManuallyEnterTime: Bool {
        return detailCubeView.memoDisplayMode == .shown || isCasual
    }
    
    private func presentManualAlert() {
        let manuallyEnterTimeAlert =
            ThemeAlertController(
                title: LocalizationGeneral.manuallyEnterTime.localized,
                message: "",
                preferredStyle: .alert)
        
        let doneEnteringAction =
            UIAlertAction(
                title: LocalizationGeneral.done.localized,
                style: .default, handler: { (_) in
                    guard
                        let timeString = manuallyEnterTimeAlert.textFields?.first?.text,
                        let time = self.parseTimeString(timeString)
                        else { return }
                    self.timerLabel.manuallyEntered(time: time)
                    self.timerDidFinish(self.timerLabel)
            })
        manuallyEnterTimeAlert.addAction(doneEnteringAction)
        manuallyEnterTimeAlert.addAction(cancelAction())
        manuallyEnterTimeAlert.addTextField { (textField) in
            textField.placeholder = LocalizationGeneral.enterYourTime.localized
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        present(manuallyEnterTimeAlert, animated: true)
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
