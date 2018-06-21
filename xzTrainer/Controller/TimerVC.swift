//
//  TimerVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    @IBOutlet weak var scrambleTextField: UITextField!
    @IBOutlet weak var cubeView: CubeView!
    @IBOutlet weak var timerLabel: TimerLabel!
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var resultTableView: UIView!
    @IBOutlet weak var resultTable: ResultTableView!
    @IBOutlet weak var swipableView: RoundedView!
    @IBOutlet weak var resultTableTriggerButton: UIButtonX!
    
    // Floating Action Buttons
    @IBOutlet weak var floatingPlus: UIButtonX!
    @IBOutlet weak var inTimerSettingButton: UIButtonX!
    @IBOutlet weak var nextScrambleButton: UIButtonX!
    @IBOutlet weak var manuallyEnterTimeButton: UIButtonX!
    
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
    
    // session picker
    @IBOutlet weak var sessionTable: SessionTableView!
    @IBOutlet weak var sessionTextField: UITextField!
    
    // result table constraints
    private var hiddenResultTableViewTopConstraint: NSLayoutConstraint?
    private var shownResultTableViewTopConstraint: NSLayoutConstraint?
    
    private var hiddenTableTopConstraint: NSLayoutConstraint?
    private var shownTableTopConstraint: NSLayoutConstraint?
    
    private var hiddenTableTriggerTopConstraint: NSLayoutConstraint?
    private var shownTableTriggerTopConstraint: NSLayoutConstraint?
    let data = GlobalData.shared
    
    var currentIndexPath: IndexPath!
    
    
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
        setUpSessionTableConstraints()
        setUpFABConstraints()
        hideFABs()
        updateView()
        
        timerLabel.delegate = self
        resultTable.delegate = self
        resultTable.dataSource = data
        sessionTable.delegate = self
        sessionTable.dataSource = data
        sessionTextField.delegate = self
        
        swipableView.isUserInteractionEnabled = true
        resultTableView.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.sessionSelected), name: NSNotification.Name(rawValue: "SessionSelected"), object: nil)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cubeView.layingContraint()
    }
    
    private func setUpSessionTableConstraints() {
        view.insertSubview(sessionTable, aboveSubview: dismissPopUpButton)
        sessionTable.center = view.center
        sessionTable.transform = CGAffineTransform(translationX: 0, y: view.frame.height)

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
        view.insertSubview(resultTableView, belowSubview: dismissPopUpButton)
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
            equalTo: resultTableView.bottomAnchor, constant: -60).isActive = true
        
        hiddenTableTriggerTopConstraint?.isActive = true
        
        resultTableTriggerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultTableTriggerButton.widthAnchor.constraint(
            equalToConstant: 20).isActive = true
        resultTableTriggerButton.heightAnchor.constraint(
            equalToConstant: 20).isActive = true
    }
    
    private func setUpFABConstraints() {
        floatingPlus.translatesAutoresizingMaskIntoConstraints = false
        inTimerSettingButton.translatesAutoresizingMaskIntoConstraints = false
        nextScrambleButton.translatesAutoresizingMaskIntoConstraints = false
        manuallyEnterTimeButton.translatesAutoresizingMaskIntoConstraints = false
        
        floatingPlus.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height - 190).isActive = true
        floatingPlus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        floatingPlus.widthAnchor.constraint(equalToConstant: 56).isActive = true
        floatingPlus.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        inTimerSettingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height - 260).isActive = true
        inTimerSettingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        inTimerSettingButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        inTimerSettingButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nextScrambleButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height - 315).isActive = true
        nextScrambleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        nextScrambleButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nextScrambleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        manuallyEnterTimeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height - 370).isActive = true
        manuallyEnterTimeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        manuallyEnterTimeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        manuallyEnterTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        hiddenTableTriggerTopConstraint = resultTableTriggerButton.topAnchor.constraint(equalTo: resultTableView.topAnchor, constant: 12)
        shownTableTriggerTopConstraint = resultTableTriggerButton.topAnchor.constraint(equalTo: resultTableView.topAnchor, constant: 40)
    }
    
    func appendNewSolve() {
        let currentSolve = data.requestSolve()
        currentSolve.time = timerLabel.time
        currentSolve.scramble = scrambleTextField.text!
        currentSolve.edgeMemo = edgeMemoLabel.text!
        currentSolve.cornerMemo = cornerMemoLabel.text!
        currentSolve.edgeFlips = ""
        currentSolve.cornerTwists = ""
        currentSolve.date = Date()
        currentSolve.penalty = 0
        data.append(solve: currentSolve)
    }
    
    @IBAction func floatingPlusPressed (_ sender: UIButton) {
        if dismissPopUpButton.alpha == 0 {
            if floatingPlus.transform == .identity {
                UIView.animate(withDuration: 0.4) {
                    self.showFABs()
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.hideFABs()
                }
            }
        } else {
            let session = data.requestSession()
            session.id = Int32(Date().timeIntervalSince1970)
            session.name = Date().description
            data.append(session: session)
            sessionTable.reloadData()
        }
    }
    
    func hideFABs() {
        inTimerSettingButton.transform = CGAffineTransform(translationX: 0, y: 78)
        nextScrambleButton.transform = CGAffineTransform(translationX: 0, y: 133)
        manuallyEnterTimeButton.transform = CGAffineTransform(translationX: 0, y: 188)
        floatingPlus.transform = .identity
    }
    
    func showFABs() {
        inTimerSettingButton.transform = .identity
        nextScrambleButton.transform = .identity
        manuallyEnterTimeButton.transform = .identity
        floatingPlus.transform = CGAffineTransform(rotationAngle: 3 * .pi / 4)
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
        if textField == scrambleTextField {
            scrambleTextField.resignFirstResponder()
            updateCube(withScramble: scrambleTextField.text!)
        }
        return false
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == sessionTextField {
            sessionTablePopIn()
            return false
        }
        return true
    }
}
