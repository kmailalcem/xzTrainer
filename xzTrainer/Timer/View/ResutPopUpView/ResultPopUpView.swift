//
//  ResultPopUpView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

fileprivate func doubleEqual(_ d1: Double, _ d2: Double) -> Bool {
    return abs(d1 - d2) < 0.001
}

class ResultPopUpView: RoundedView {

    @IBOutlet weak var scrambleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mo3Label: UILabel!
    @IBOutlet weak var ao5Label: UILabel!
    @IBOutlet weak var ao12Label: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var plusTwoButtion: RoundedButton!
    @IBOutlet weak var okButton: RoundedButton!
    @IBOutlet weak var dnfButton: RoundedButton!
    
    var currentIndexPath: IndexPath!
    var rootViewController: TimerVC!
    
    let data = GlobalData.shared
    
    @IBAction func plusTwo() {
        plusTwoButtion.isSelected = !plusTwoButtion.isSelected
        okButton.isSelected = false
        dnfButton.isSelected = false
        let index = data.backIndex(currentIndexPath.row)
        if plusTwoButtion.isSelected {
            data.plusTwo(forSolveAt: index)
        } else {
            data.okay(forSolveAt: index)
        }
        cleanUpForPenaltyUpdate()
    }
    
    @IBAction func okay() {
        plusTwoButtion.isSelected = false
        dnfButton.isSelected = false
        let index = data.backIndex(currentIndexPath.row)
        data.okay(forSolveAt: index)
        cleanUpForPenaltyUpdate()
    }
    
    @IBAction func dnf() {
        plusTwoButtion.isSelected = false
        okButton.isSelected = false
        dnfButton.isSelected = !dnfButton.isSelected
        let index = data.backIndex(currentIndexPath.row)
        if dnfButton.isSelected {
            data.dnf(forSolveAt: index)
        } else {
            data.okay(forSolveAt: index)
        }
        cleanUpForPenaltyUpdate()
    }
    
    private func cleanUpForPenaltyUpdate() {
        // resultTable.reloadData()
        configurePopUp(indexPath: currentIndexPath)
    }
    
    func configurePopUp(indexPath: IndexPath) {
        shadowRadius = 8
        shadowOpacity = 0.125
        currentIndexPath = indexPath
        let solve = data.requestSolve(at: data.backIndex(indexPath.row))
        scrambleLabel.text = solve.scramble
        timeLabel.text = convertTimeDoubleToString(solve.timeIncludingPenalty)
        mo3Label.text = convertTimeDoubleToString(solve.mo3)
        ao5Label.text = convertTimeDoubleToString(solve.ao5)
        ao12Label.text = convertTimeDoubleToString(solve.ao12)
        let chineseDateFormatter = DateFormatter()
        chineseDateFormatter.dateFormat = "(yyyy-MM-dd HH:mm:ss)"
        dateLabel.text = chineseDateFormatter.string(from: solve.date!)
        plusTwoButtion.isSelected = doubleEqual(solve.penalty, 2)
        dnfButton.isSelected = solve.penalty == Double.infinity
    }
    
    
    @IBAction func showDetail() {
        rootViewController.performSegue(withIdentifier: "toSolveDetail", sender: data.backIndex(currentIndexPath.row))
    }
    
}
