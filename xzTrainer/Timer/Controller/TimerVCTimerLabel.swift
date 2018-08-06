//
//  TimerVCTimerLabel.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

extension TimerVC: TimerLabelDelegate {
    
    func timerDidStart(_ sender: TimerLabel) {
        showMemo()
        
        if !isCasual {
            cubeView.showAllFaces()
        }
        
        sender.startTimer(delay: (isCasual || memoIsShown) ? 0 : 0.7)
        sender.textColor = TimerLabel.defaultColor
    }
    
    func timerDidFinish(_ sender: TimerLabel) {
        appendNewSolve()
        updateView()
        resultTable.reloadData()
    }
    
    func showMemo() {
        let memorizer = CubePermutationEncoder(
            forScramble: scrambleTextField.text!)
        
        edgeMemoLabel.text = memorizer.formattedEdgeMemo
        cornerMemoLabel.text = memorizer.formattedCornerMemo
    }
}
