//
//  TimerVCPopUp.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit


// managing popup view
extension TimerVC {
    
    func animatePopUpIn() {
        self.view.addSubview(popUpDetailView)
        popUpDetailView.alpha = 0
        self.popUpDetailView.center = self.view.center
        self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpDetailView.alpha = 1
            self.popUpDetailView.transform = CGAffineTransform.identity
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SolveDetailVC {
            destination.currentSolve = data.requestSolve(at: sender as! Int)
        }
    }
}

