//
//  SolveDetailVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
import CoreData

class SolveDetailVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var pbLabel: UILabel!
    @IBOutlet weak var mo3Label: UILabel!
    @IBOutlet weak var ao5Label: UILabel!
    @IBOutlet weak var ao12Label: UILabel!
    @IBOutlet weak var ao100Label: UILabel!
    @IBOutlet weak var ao1000Label: UILabel!
    @IBOutlet weak var scrambleLabel: UILabel!
    
    @IBOutlet weak var cubeView: CubeView!
    
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var currentSolve: Solve!
    
    @IBAction func didTapScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backToTableButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cubeView.layingContraint()
        updateAOLabels()
    }
    
    @IBAction func copyScramble() {
        UIPasteboard.general.string = scrambleLabel.text!
    }
    
    private func updateAOLabels() {
        currentTimeLabel.text = convertTimeDoubleToString(
            currentSolve.timeIncludingPenalty)
        scrambleLabel.text = currentSolve.scramble
        cubeView.showScramble(currentSolve.scramble!)
        edgeMemoLabel.text = currentSolve.edgeMemo
        cornerMemoLabel.text = currentSolve.cornerMemo
        
        let (best, mo3, ao5, ao12, ao100, ao1000) =
            (currentSolve.best, currentSolve.mo3, currentSolve.ao5,
             currentSolve.ao12, currentSolve.ao100,
             currentSolve.ao1000)
        
        pbLabel.text = convertTimeDoubleToString(best)
        mo3Label.text = convertTimeDoubleToString(mo3)
        ao5Label.text = convertTimeDoubleToString(ao5)
        ao12Label.text = convertTimeDoubleToString(ao12)
        ao100Label.text = convertTimeDoubleToString(ao100)
        ao1000Label.text = convertTimeDoubleToString(ao1000)
    }
}
