//
//  TimerVCPopUp.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

fileprivate func doubleEqual(_ d1: Double, _ d2: Double) -> Bool {
    return abs(d1 - d2) < 0.001
}

// managing popup view
extension TimerVC {
    
    
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        animatePopUpOut()
    }
    
    @IBAction func plusTwo() {
        plusTwoButtion.isSelected = !plusTwoButtion.isSelected
        okButton.isSelected = false
        dnfButton.isSelected = false
        let solve = userSolves[userSolves.count - currentIndexPath.row - 1]
        if plusTwoButtion.isSelected {
            solve.penalty = 2
        } else {
            solve.penalty = 0
        }
        cleanUpForPenaltyUpdate()
    }
    
    @IBAction func okay() {
        plusTwoButtion.isSelected = false
        dnfButton.isSelected = false
        let solve = userSolves[userSolves.count - currentIndexPath.row - 1]
        solve.penalty = 0
        cleanUpForPenaltyUpdate()
    }
    
    @IBAction func dnf() {
        plusTwoButtion.isSelected = false
        okButton.isSelected = false
        dnfButton.isSelected = !dnfButton.isSelected
        let solve = userSolves[userSolves.count - currentIndexPath.row - 1]
        if dnfButton.isSelected {
            solve.penalty = Double.infinity
        } else {
            solve.penalty = 0
        }
        cleanUpForPenaltyUpdate()
    }
    
    
    func configurePopUp(indexPath: IndexPath) {
        currentIndexPath = indexPath
        let solve = userSolves[userSolves.count - indexPath.row - 1]
        puScrambleLabel.text = solve.scramble
        puTimeLabel.text = convertTimeDoubleToString(solve.timeIncludingPenalty)
        puMo3Label.text = convertTimeDoubleToString(solve.mo3)
        puAo5Label.text = convertTimeDoubleToString(solve.ao5)
        puAo12Label.text = convertTimeDoubleToString(solve.ao12)
        let chineseDateFormatter = DateFormatter()
        chineseDateFormatter.dateFormat = "(yyyy-MM-dd HH:mm:ss)"
        puDateLabel.text = chineseDateFormatter.string(from: solve.date!)
        plusTwoButtion.isSelected = doubleEqual(solve.penalty, 2)
        dnfButton.isSelected = solve.penalty == Double.infinity
    }
    
    func animatePopUpIn() {
        self.view.addSubview(popUpDetailView)
        popUpDetailView.alpha = 0
        self.popUpDetailView.center = self.view.center
        self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpDetailView.alpha = 0.9
            self.dismissPopUpButton.alpha = 0.5
            self.popUpDetailView.transform = CGAffineTransform.identity
        })
    }
    
    func animatePopUpOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dismissPopUpButton.alpha = 0
            self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popUpDetailView.alpha = 0
        }, completion: {success in
            self.popUpDetailView.removeFromSuperview()
        })
    }
}

