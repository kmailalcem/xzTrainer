//
//  SolveDetailVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/22/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SolveDetailVC: ThemeViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var pbLabel: UILabel!
    @IBOutlet weak var mo3Label: UILabel!
    @IBOutlet weak var ao5Label: UILabel!
    @IBOutlet weak var ao12Label: UILabel!
    @IBOutlet weak var ao100Label: UILabel!
    @IBOutlet weak var ao1000Label: UILabel!
    @IBOutlet weak var detailCubeView: DetailCubeView!
    
    var currentSolve: Solve!
    
    @IBAction func didTapScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        detailCubeView.cubeView.settingFrame()
    }
    
    @IBAction func backToTableButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailView()
        updateTimeLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    fileprivate func setUpDetailView() {
        detailCubeView.forceScrambleInStandardOrientation = true
        detailCubeView.updateCube(withScramble: currentSolve.scramble!)
        detailCubeView.memoDisplayMode = .shown
    }
    
    fileprivate func updateTimeLabels() {
        currentTimeLabel.text = convertTimeDoubleToString(currentSolve.timeIncludingPenalty)
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
