//
//  TimerVCSessionManager.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/21/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

extension TimerVC {
    @objc func sessionSelected (_ notification: NSNotification) {
        resultTable.reloadData()
    }
    
    func sessionTablePopIn() {
        view.bringSubview(toFront: floatingPlus)
        floatingPlus.transform = CGAffineTransform(translationX: 0, y: 190)
        UIView.animate(withDuration: 0.4) {
            self.dismissPopUpButton.alpha = 0.5
            self.view.insertSubview(self.dismissPopUpButton, belowSubview: self.sessionTable)
            self.sessionTable.transform = .identity
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseIn, animations: {
            self.floatingPlus.transform = CGAffineTransform(translationX: 0, y: 120)
        }, completion: nil)
        
        sessionTableIsShown = true
    }
    
    func sessionTablePopOut() {
        UIView.animate(withDuration: 0.2) {
            self.dismissPopUpButton.alpha = 0
            self.sessionTable.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
            self.floatingPlus.transform = CGAffineTransform(translationX: 0, y: 190)
        }) { (success) in
            self.floatingPlus.transform = .identity
            self.view.insertSubview(self.floatingPlus, aboveSubview: self.manuallyEnterTimeButton)
        }
        sessionTableIsShown = false
    }
}
