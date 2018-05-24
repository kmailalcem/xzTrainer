//
//  SolveDetailVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class SolveDetailVC: UIViewController {
    
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var mo3Label: UILabel!
    @IBOutlet var ao5Label: UILabel!
    @IBOutlet var ao12Label: UILabel!
    @IBOutlet var ao50Label: UILabel!
    @IBOutlet var ao100Label: UILabel!
    @IBOutlet var ao1000Label: UILabel!
    @IBOutlet var scrambleLabel: UILabel!
    @IBOutlet var cubeView: CubeView!
    
    var userSolves: [SolveTime]!
    var endingIndex: Int!
    
    @IBAction func backToTableButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTimeLabel.text = String(
            format: "%.3f", userSolves[endingIndex - 1].time)
        scrambleLabel.text = userSolves[endingIndex - 1].scramble
        
        updateAOLabels()
        cubeView.showScramble(scrambleLabel.text!)
    }
    
    private func updateAOLabels() {
        if let mo3 = userSolves.mo(3, ending: endingIndex) {
            mo3Label.text = String(format: "%.3f", mo3)
        } else {
            mo3Label.text = "N/A"
        }
        
        if let ao5 = userSolves.ao(5, ending: endingIndex) {
            ao5Label.text = String(format: "%.3f", ao5)
        } else {
            ao5Label.text = "N/A"
        }
        
        if let ao12 = userSolves.ao(12, ending: endingIndex) {
            ao12Label.text = String(format: "%.3f", ao12)
        } else {
            ao12Label.text = "N/A"
        }
        
        if let ao50 = userSolves.ao(50, ending: endingIndex) {
            ao50Label.text = String(format: "%.3f", ao50)
        } else {
            ao50Label.text = "N/A"
        }
        
        if let ao100 = userSolves.ao(100, ending: endingIndex) {
            ao100Label.text = String(format: "%.3f", ao100)
        } else {
            ao100Label.text = "N/A"
        }
        
        if let ao1000 = userSolves.ao(1000, ending: endingIndex) {
            ao1000Label.text = String(format: "%.3f", ao1000)
        } else {
            ao1000Label.text = "N/A"
        }
    }
}
