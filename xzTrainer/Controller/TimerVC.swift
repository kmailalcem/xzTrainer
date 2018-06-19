//
//  TimerVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
import CoreData

class TimerVC: UIViewController {
    
    @IBOutlet weak var scrambleTextField: UITextField!
    @IBOutlet weak var cubeView: CubeView!
    @IBOutlet weak var timerLabel: TimerLabel!
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var resultTableView: UIView!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var swipableView: RoundedView!
    @IBOutlet weak var resultTableTriggerButton: UIButtonX!
    
    // Pop up window
    @IBOutlet weak var popUpDetailView: RoundedView!
    @IBOutlet weak var dismissPopUpButton: UIButton!
    @IBOutlet weak var puScrambleLabel: UILabel!
    @IBOutlet weak var puTimeLabel: UILabel!
    @IBOutlet weak var puMo3Label: UILabel!
    @IBOutlet weak var puAo5Label: UILabel!
    @IBOutlet weak var puAo12Label: UILabel!
    @IBOutlet weak var puDateLabel: UILabel!
    @IBOutlet weak var plusTwoButtion: RoundedButton!
    @IBOutlet weak var okButton: RoundedButton!
    @IBOutlet weak var dnfButton: RoundedButton!
    
    // result table constraints
    private var hiddenResultTableViewTopConstraint: NSLayoutConstraint?
    private var shownResultTableViewTopConstraint: NSLayoutConstraint?
    
    private var hiddenTableTopConstraint: NSLayoutConstraint?
    private var shownTableTopConstraint: NSLayoutConstraint?
    
    private var hiddenTableTriggerTopConstraint: NSLayoutConstraint?
    private var shownTableTriggerTopConstraint: NSLayoutConstraint?
    
    
    var currentIndexPath: IndexPath!
    
    func cleanUpForPenaltyUpdate() {
        updateStatsFromIndex(userSolves.count - currentIndexPath.row - 1)
        saveData()
        resultTable.reloadData()
        configurePopUp(indexPath: currentIndexPath)
    }
    
    @IBAction func showDetail() {
        performSegue(withIdentifier: "toSolveDetail",
                     sender: userSolves[userSolves.count - currentIndexPath.row - 1])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SolveDetailVC {
            if let solve = sender as? Solve {
                destination.currentSolve = solve
            }
        }
    }
    
    var userSolves: [Solve] = []
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    
    
    @IBAction func resultTableTriggered(_ sender: UIButtonX) {
        if (hiddenTableTopConstraint?.isActive)! {
            swipeUpDetected()
        } else {
            swipeDownDetected()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScrambleTexTField()
        setUpSwipeRecognizers()
        setUpResultTableViewConstraints()
        loadData()
        updateView()
        
        timerLabel.delegate = self
        resultTable.delegate = self
        resultTable.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cubeView.layingContraint()
    }
    
    private func setUpScrambleTexTField() {
        self.view.isUserInteractionEnabled = true
        cubeView.cube = Cube(top: .WHITE, front: .GREEN, scramble: "")
        scrambleTextField.delegate = self
        scrambleTextField.borderStyle = .none
    }
    
    private func setUpSwipeRecognizers() {
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerVC.swipeUpDetected))
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerVC.swipeDownDetected))
        swipeUpRecognizer.direction = .up
        swipeUpRecognizer.cancelsTouchesInView = false
        swipeDownRecognizer.direction = .down
        swipeDownRecognizer.cancelsTouchesInView = false
        swipableView.addGestureRecognizer(swipeUpRecognizer)
        swipableView.addGestureRecognizer(swipeDownRecognizer)
    }
    
    @objc func swipeUpDetected() {
        print("swipe detected")
        hiddenResultTableViewTopConstraint?.isActive = false
        shownResultTableViewTopConstraint?.isActive = true
        
        hiddenTableTopConstraint?.isActive = false
        shownTableTopConstraint?.isActive = true
        
        hiddenTableTriggerTopConstraint?.isActive = false
        shownTableTriggerTopConstraint?.isActive = true
        UIView.animate(withDuration: 0.4) {
            self.resultTableTriggerButton.transform =
                CGAffineTransform(rotationAngle: .pi)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func swipeDownDetected() {
        shownResultTableViewTopConstraint?.isActive = false
        hiddenResultTableViewTopConstraint?.isActive = true
        
        shownTableTopConstraint?.isActive = false
        hiddenTableTopConstraint?.isActive = true
        
        shownTableTriggerTopConstraint?.isActive = false
        hiddenTableTriggerTopConstraint?.isActive = true
        UIView.animate(withDuration: 0.4) {
            self.resultTableTriggerButton.transform = CGAffineTransform.identity
            self.view.layoutIfNeeded()
        }
    }
    
    private func setUpResultTableViewConstraints() {
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTable.translatesAutoresizingMaskIntoConstraints = false
        resultTableTriggerButton.translatesAutoresizingMaskIntoConstraints = false
        initializeTopConstraints()
        
        hiddenResultTableViewTopConstraint?.isActive = true
        
        resultTableView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        resultTableView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        resultTableView.heightAnchor.constraint(
            equalToConstant: view.frame.height).isActive = true
        
        hiddenTableTopConstraint?.isActive = true
        
        resultTable.leadingAnchor.constraint(
            equalTo: resultTableView.leadingAnchor).isActive = true
        resultTable.trailingAnchor.constraint(
            equalTo: resultTableView.trailingAnchor).isActive = true
        resultTable.bottomAnchor.constraint(
            equalTo: resultTableView.bottomAnchor).isActive = true
        
        hiddenTableTriggerTopConstraint?.isActive = true
        
        resultTableTriggerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultTableTriggerButton.widthAnchor.constraint(
            equalToConstant: 30).isActive = true
        resultTableTriggerButton.heightAnchor.constraint(
            equalToConstant: 30).isActive = true
    }
    
    fileprivate func initializeTopConstraints() {
        hiddenResultTableViewTopConstraint =
            resultTableView.topAnchor.constraint(
                equalTo: view.topAnchor, constant: view.frame.height - 120)
         shownResultTableViewTopConstraint =
            resultTableView.topAnchor.constraint(equalTo: view.topAnchor)
        hiddenTableTopConstraint = resultTable.topAnchor.constraint(
            equalTo: resultTableView.topAnchor, constant: 40)
        shownTableTopConstraint = resultTable.topAnchor.constraint(
            equalTo: resultTableView.topAnchor, constant: 80)
        hiddenTableTriggerTopConstraint = resultTableTriggerButton.topAnchor.constraint(equalTo: resultTableView.topAnchor, constant: 5)
        shownTableTriggerTopConstraint = resultTableTriggerButton.topAnchor.constraint(equalTo: resultTableView.topAnchor, constant: 35)
    }
    
    func loadData() {
        let solvesRequest: NSFetchRequest<Solve> = Solve.fetchRequest()
        do {
            try userSolves = managedObjectContext.fetch(solvesRequest)
        } catch {
            print("error fetching solves request. Message: \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        do {
            try managedObjectContext.save()
        }catch {
            print("Error saving solve data. Message: \(error.localizedDescription)")
        }
        
    }
    
    func appendNewSolve() {
        let currentSolve = Solve(context: managedObjectContext)
        userSolves.append(currentSolve)
        currentSolve.time = timerLabel.time
        currentSolve.best = userSolves.min()!.timeIncludingPenalty
        currentSolve.scramble = scrambleTextField.text!
        updateStatsFromIndex(userSolves.count - 1)
        currentSolve.edgeMemo = edgeMemoLabel.text!
        currentSolve.cornerMemo = cornerMemoLabel.text!
        currentSolve.edgeFlips = ""
        currentSolve.cornerTwists = ""
        currentSolve.date = Date()
        currentSolve.penalty = 0
        userSolves[userSolves.count - 1] = currentSolve
    }
    
    
    
    func updateStatsFromIndex(_ index: Int) {
        if index < userSolves.count {
            for i in index ..< userSolves.count {
                let currentSolve = userSolves[i]
                currentSolve.best = userSolves.min()!.timeIncludingPenalty
                currentSolve.mo3 = userSolves.mo(3, ending: i + 1)
                currentSolve.ao5 = userSolves.ao(5, ending: i + 1)
                currentSolve.ao12 = userSolves.ao(12, ending: i + 1)
                currentSolve.ao50 = userSolves.ao(50, ending: i + 1)
                currentSolve.ao100 = userSolves.ao(100, ending: i + 1)
                currentSolve.ao1000 = userSolves.ao(1000, ending: i + 1)
                userSolves[i] = currentSolve
            }
        }
    }
    
    func deleteSolve(atIndex index: Int) {
        if index < userSolves.count {
            managedObjectContext.delete(userSolves[index])
            saveData()
            userSolves.remove(at: index)
            updateStatsFromIndex(index)
        }
    }
    
    private func updateCube (withScramble scramble: String) {
        let cube = cubeView.cube
        cube.reScrambleCube(scramble)
        cubeView.cube = cube
        cubeView.updateFaces()
    }
    
    func updateView() {
        scrambleTextField.text = Scrambler.getRandomScrambleWithLength(from: 19, to: 22)
        updateCube(withScramble: scrambleTextField.text!)
        UIView.animate(withDuration: 0.8) {
            self.cubeView.hideFacesExceptFront()
        }
        
        edgeMemoLabel.text = "Reveal memo by starting the timer."
        cornerMemoLabel.text = "You will have 0.5 seconds to react."
    }
    
}

extension TimerVC: UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBAction func didTapScreen(_ sender: Any) {
        if scrambleTextField.isFirstResponder {
            scrambleTextField.resignFirstResponder()
        }
    }
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scrambleTextField.resignFirstResponder()
        updateCube(withScramble: scrambleTextField.text!)
        return false
    }
}
