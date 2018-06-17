//
//  TimerVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit
import CoreData

class TimerVC:
    UIViewController,
    UITextFieldDelegate,
    TimerLabelDelegate,
    UIGestureRecognizerDelegate,
    UITableViewDelegate,
    UITableViewDataSource {
    
    // Pop up window
    @IBOutlet weak var popUpDetailView: RoundedView!
    @IBOutlet weak var dismissPopUpButton: UIButton!
    @IBAction func dismissPopUp(_ sender: UIButton) {
        animatePopUpOut()
    }
    
    @IBOutlet weak var puScrambleLabel: UILabel!
    @IBOutlet weak var puTimeLabel: UILabel!
    @IBOutlet weak var puMo3Label: UILabel!
    @IBOutlet weak var puAo5Label: UILabel!
    @IBOutlet weak var puAo12Label: UILabel!
    @IBOutlet weak var puDateLabel: UILabel!
    @IBOutlet weak var plusTwoButtion: RoundedButton!
    @IBOutlet weak var okButton: RoundedButton!
    @IBOutlet weak var dnfButton: RoundedButton!
    var currentIndexPath: IndexPath!
    
    @IBAction func plusTwo() {
        plusTwoButtion.isSelected = !plusTwoButtion.isSelected
        okButton.isSelected = false
        dnfButton.isSelected = false
        let solve = userSolves[userSolves.count - currentIndexPath.row - 1]
        if plusTwoButtion.isSelected {
            solve.penalty = 2
        } else {
            solve.penalty = 0
        }
        cleanUpForPenaltyUpdate()
    }
    
    @IBAction func okay() {
        plusTwoButtion.isSelected = false
        dnfButton.isSelected = false
        let solve = userSolves[userSolves.count - currentIndexPath.row - 1]
        solve.penalty = 0
        cleanUpForPenaltyUpdate()
    }
    
    @IBAction func dnf() {
        plusTwoButtion.isSelected = false
        okButton.isSelected = false
        dnfButton.isSelected = !dnfButton.isSelected
        let solve = userSolves[userSolves.count - currentIndexPath.row - 1]
        if dnfButton.isSelected {
            solve.penalty = Double.infinity
        } else {
            solve.penalty = 0
        }
        cleanUpForPenaltyUpdate()
    }
    
    private func cleanUpForPenaltyUpdate() {
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
   
    @IBOutlet weak var scrambleTextField: UITextField!
    @IBOutlet weak var cubeView: CubeView!
    @IBOutlet weak var timerLabel: TimerLabel!
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var resultTableView: UIView!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var swipableView: RoundedView!
    @IBOutlet weak var resultTableTriggerButton: UIButtonX!
    
    private var hiddenResultTableViewTopConstraint: NSLayoutConstraint?
    private var shownResultTableViewTopConstraint: NSLayoutConstraint?
    
    private var hiddenTableTopConstraint: NSLayoutConstraint?
    private var shownTableTopConstraint: NSLayoutConstraint?
    
    private var hiddenTableTriggerTopConstraint: NSLayoutConstraint?
    private var shownTableTriggerTopConstraint: NSLayoutConstraint?
    
    var userSolves: [Solve] = []
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func didTapScreen(_ sender: Any) {
        if scrambleTextField.isFirstResponder {
            scrambleTextField.resignFirstResponder()
        }
    }
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scrambleTextField.resignFirstResponder()
        updateCube(withScramble: scrambleTextField.text!)
        return false
    }
    
    
    func timerDidStart(_ sender: TimerLabel) {
        let memorizer = CubePermutationEncoder(
            forScramble: scrambleTextField.text!)

        edgeMemoLabel.text = memorizer.formattedEdgeMemo
        cornerMemoLabel.text = memorizer.formattedCornerMemo
        
        cubeView.showAllFaces()
        sender.startTimer(delay: 0.7)
        sender.textColor = TimerLabel.defaultColor
    }
    
    func timerDidFinish(_ sender: TimerLabel) {
        appendNewSolve()
        saveData()
        updateView()
        resultTable.reloadData()
    }
    
    private func saveData() {
        do {
            try managedObjectContext.save()
        }catch {
            print("Error saving solve data. Message: \(error.localizedDescription)")
        }
        
    }
    
    private func appendNewSolve() {
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
    
    private func doubleEqual(_ d1: Double, _ d2: Double) -> Bool {
        return abs(d1 - d2) < 0.001
    }
    
    private func updateStatsFromIndex(_ index: Int) {
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
    
    private func deleteSolve(atIndex index: Int) {
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
    
    private func updateView() {
        scrambleTextField.text = Scrambler.getRandomScrambleWithLength(from: 15, to: 20)
        updateCube(withScramble: scrambleTextField.text!)
        UIView.animate(withDuration: 0.8) {
            self.cubeView.hideFacesExceptFront()
        }
        
        edgeMemoLabel.text = "Reveal memo by starting the timer."
        cornerMemoLabel.text = "You will have 0.5 seconds to react."
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSolves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTable.dequeueReusableCell(
            withIdentifier: "ResultCell", for: indexPath)
        if let resultCell = cell as? ResultCell {
            resultCell.configureCell(index: userSolves.count - indexPath.row - 1,
                                     solveStats: userSolves)
            let newView = UIView()
            let extractedExpr: UIColor = UIColor(red: 0x92/255 ,
                                                 green: 0xa6/255,
                                                 blue:0xbe/255,
                                                 alpha: 1)
            newView.backgroundColor = extractedExpr
            resultCell.selectedBackgroundView? = newView
            return resultCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        configurePopUp(indexPath: indexPath)
        animatePopUpIn()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") {_,_ in
            self.deleteSolve(atIndex: self.userSolves.count - indexPath.row - 1)
            self.resultTable.reloadData()
        }
        
        delete.backgroundColor = .red
        return [delete]
    }
    
    private func configurePopUp(indexPath: IndexPath) {
        currentIndexPath = indexPath
        let solve = userSolves[userSolves.count - indexPath.row - 1]
        puScrambleLabel.text = solve.scramble
        puTimeLabel.text = convertTimeDoubleToString(solve.timeIncludingPenalty)
        puMo3Label.text = convertTimeDoubleToString(solve.mo3)
        puAo5Label.text = convertTimeDoubleToString(solve.ao5)
        puAo12Label.text = convertTimeDoubleToString(solve.ao12)
        let chineseDateFormatter = DateFormatter()
        chineseDateFormatter.dateFormat = "(yyyy-MM-dd HH:mm:ss)"
        puDateLabel.text = chineseDateFormatter.string(from: solve.date!)
        plusTwoButtion.isSelected = doubleEqual(solve.penalty, 2)
        dnfButton.isSelected = solve.penalty == Double.infinity
    }
    
    private func animatePopUpIn() {
        self.view.addSubview(popUpDetailView)
        popUpDetailView.alpha = 0
        self.popUpDetailView.center = self.view.center
        self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpDetailView.alpha = 0.9
            self.dismissPopUpButton.alpha = 0.5
            self.popUpDetailView.transform = CGAffineTransform.identity
        })
    }
    
    private func animatePopUpOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dismissPopUpButton.alpha = 0
            self.popUpDetailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popUpDetailView.alpha = 0
        }, completion: {success in
            self.popUpDetailView.removeFromSuperview()
        })
    }
}

