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
    
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var mo3Label: UILabel!
    @IBOutlet var ao5Label: UILabel!
    @IBOutlet var ao12Label: UILabel!
    @IBOutlet var ao50Label: UILabel!
    @IBOutlet var ao100Label: UILabel!
    @IBOutlet var ao1000Label: UILabel!
    @IBOutlet var scrambleLabel: UILabel!
    @IBOutlet var cubeView: CubeView!
    
    @IBOutlet var contentView: UIView!
    
    @IBAction func didTapScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var solves: [Solve]!
    var endingIndex: Int!
    let managedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    @IBAction func backToTableButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        // updateAOLabels()
        // cubeView.showScramble(scrambleLabel.text!)
    }
    
    private func updateAOLabels() {
        let currentSolve = solves[endingIndex]
        currentTimeLabel.text = String(format: "%.3f", currentSolve.time)
        scrambleLabel.text = currentSolve.scramble
        let (mo3, ao5, ao12, ao50, ao100, ao1000) =
            (currentSolve.mo3, currentSolve.ao5,
             currentSolve.ao12, currentSolve.ao50,
             currentSolve.ao100, currentSolve.ao1000)
        
        mo3Label.text = convertTimeDoubleToString(mo3)
        ao5Label.text = convertTimeDoubleToString(ao5)
        ao12Label.text = convertTimeDoubleToString(ao12)
        ao50Label.text = convertTimeDoubleToString(ao50)
        ao100Label.text = convertTimeDoubleToString(ao100)
        ao1000Label.text = convertTimeDoubleToString(ao1000)
    }
    
    func loadData() {
        let solvesRequest: NSFetchRequest<Solve> = Solve.fetchRequest()
        do {
            try solves = managedObjectContext.fetch(solvesRequest)
            // updateAOLabels()
        } catch {
            print("error fetching solves request. Message: \(error.localizedDescription)")
        }
    }
}
