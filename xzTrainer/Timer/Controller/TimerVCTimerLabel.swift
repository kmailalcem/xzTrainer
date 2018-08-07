//
//  TimerVCTimerLabel.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
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
