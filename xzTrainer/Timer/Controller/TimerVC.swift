//
//  TimerVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    var isCasual: Bool = true
    @IBOutlet weak var scrambleTextField: UILabel!
    @IBOutlet weak var cubeView: CubeView!
    @IBOutlet weak var timerLabel: TimerLabel!
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var resultTableView: UIView!
    @IBOutlet weak var resultTable: ResultTableView!
    @IBOutlet weak var swipableView: RoundedView!
    @IBOutlet weak var resultTableTriggerButton: UIButtonX!
    @IBOutlet weak var memoStack: UIStackView!
    @IBOutlet weak var modeTitleLabel: UILabel!
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    // Floating Action Buttons
    @IBOutlet weak var floatingPlus: FloatingActionButton!
    @IBOutlet weak var inTimerSettingButton: FloatingActionButton!
    @IBOutlet weak var nextScrambleButton: FloatingActionButton!
    @IBOutlet weak var manuallyEnterTimeButton: FloatingActionButton!
    
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
    
    var sessionTableIsShown: Bool = false
    var floatingPlusIsPressed: Bool = false
    var popUpIsShown: Bool = false
    let data = GlobalData.shared
    
    var currentIndexPath: IndexPath!
    
    var resultTableIsShown: Bool = false
    
    @IBAction func resultTableTriggered(_ sender: UIButtonX) {
        if !resultTableIsShown {
            dismissPopUp(dismissPopUpButton)
            swipeUpDetected()
        } else {
            swipeDownDetected()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoStack.isHidden = isCasual
        modeTitleLabel.text = isCasual ? "Casual BLD" : "Execution Training"
        
        cubeView.layingContraint()
        setUpInitialLayout()
        assignDelegates()
        resultTable.reloadData()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.sessionSelected), name: NSNotification.Name(rawValue: "SessionSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.deletedCurrentSession), name: NSNotification.Name(rawValue: "DeletedCurrentSession"), object: nil)
    }
    
    private func setUpInitialLayout() {
        setUpScrambleTexTField()
        setUpSwipeRecognizers()
        setUpResultTableViewConstraints()
        setUpSessionTableConstraints()
        hideFABs()
        updateView()
        swipableView.isUserInteractionEnabled = true
        resultTableView.isUserInteractionEnabled = true
    }
    
    func setUpTimerConstraint() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        if isCasual {
            timerLabel.topAnchor.constraint(equalTo: cubeView.bottomAnchor).isActive = true
        } else {
            timerLabel.topAnchor.constraint(equalTo: memoStack.bottomAnchor, constant: 2).isActive = true
        }
    }
    
    private func assignDelegates() {
        timerLabel.delegate = self
        resultTable.delegate = self
        resultTable.dataSource = data
        sessionTable.delegate = self
        sessionTable.dataSource = data
        sessionTextField.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.frame = UIScreen.main.bounds
        self.view.layoutIfNeeded()
    }
    
    private func setUpSessionTableConstraints() {
        view.addSubview(sessionTable)
        sessionTable.center = view.center
        sessionTable.transform = CGAffineTransform(translationX: 0, y: view.frame.height + 200)

    }
    
    private func setUpScrambleTexTField() {
        self.view.isUserInteractionEnabled = true
        cubeView.cube = Cube(top: .WHITE, front: .GREEN, scramble: "")
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
        resultTableIsShown = true
        UIView.animate(withDuration: 0.4) {
            self.resultTableTriggerButton.transform = CGAffineTransform(rotationAngle: .pi)
            self.resultTableView.transform = .identity
            self.resultTable.transform = .identity
        }
    }
    
    @objc func swipeDownDetected() {
        resultTableIsShown = false
        UIView.animate(withDuration: 0.4) {
            self.resultTableTriggerButton.transform =  CGAffineTransform.init(translationX: 0, y: -28)
            self.resultTableView.transform = CGAffineTransform.init(translationX: 0, y: self.view.frame.height - 120)
            self.resultTable.transform = CGAffineTransform.init(translationX: 0, y: -40)
        }
    }
    
    private func setUpResultTableViewConstraints() {
        view.addSubview(resultTableView)
        
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        resultTableView.transform = CGAffineTransform.init(translationX: 0, y: view.frame.height - 120)
        resultTableTriggerButton.transform = CGAffineTransform.init(translationX: 0, y: -28)
        resultTable.transform = CGAffineTransform.init(translationX: 0, y: -40)
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
    
    
    private func updateCube (withScramble scramble: String) {
        let topColor = UserSetting.shared.general.topFaceColor
        let frontColor = UserSetting.shared.general.frontFaceColor
        let cube = Cube(top: topColor, front: frontColor, scramble: scramble)
        cubeView.cube = cube
        cubeView.updateFaces()
    }
    
    
    @IBAction func updateView() {
        scrambleTextField.text = Scrambler.getRandomScrambleWithLength(from: 19, to: 22, withOrientationMangle: !isCasual)
        updateCube(withScramble: scrambleTextField.text!)
        if isCasual {
            self.cubeView.hideFacesExceptTop()
        } else {
            UIView.animate(withDuration: 0.8) {
                self.cubeView.hideFacesExceptTop()
            }
        }
        edgeMemoLabel.text = "Reveal memo by starting the timer."
        cornerMemoLabel.text = "You will have 0.5 seconds to react."
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
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
