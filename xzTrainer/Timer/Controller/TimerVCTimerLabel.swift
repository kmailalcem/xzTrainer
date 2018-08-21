//
//  TimerVCTimerLabel.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

extension TimerVC: TimerLabelDelegate {
    
    func timerDidStart(_ sender: TimerLabel) {
        // TODO: make this nicer
        detailCubeView.memoDisplayMode = .shown
        UIApplication.shared.isIdleTimerDisabled = true;
        
        if !isCasual {
            detailCubeView.cubeView.showAllFaces()
        }
        
        sender.startTimer(delay: (isCasual || memoIsShown) ? 0 : 0.7)
        sender.textColor = TimerLabel.defaultColor
    }
    
    func timerDidFinish(_ sender: TimerLabel) {
        UIApplication.shared.isIdleTimerDisabled = false;
        appendNewSolve()
        updateView()
        resultTableView.resultTable.reloadData()
    }
}
