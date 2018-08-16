//
//  TimerVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 4/17/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

func toString(_ rotations: [Rotation]) -> String {
    var result = ""
    for rotation in rotations {
        result += rotation.rawValue + " "
    }
    return result;
}

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
    var memoIsShown = false
    
    let data = GlobalData.shared
    
    var currentIndexPath: IndexPath!
    
    var resultTableIsShown: Bool = false
    
    @IBAction func resultTableTriggered(_ sender: UIButtonX) {
        if !resultTableIsShown {
            dismissPopUp(dismissPopUpButton)
            showResultTable()
        } else {
            hideResultTable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoStack.isHidden = isCasual
        modeTitleLabel.text = isCasual ? LocalizableMode.casualBLD.localized : LocalizableMode.executionTraining.localized
        
        cubeView.settingFrame()
        setUpInitialLayout()
        assignDelegates()
        resultTable.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.sessionSelected), name: NSNotification.Name(rawValue: "SessionSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.deletedCurrentSession), name: NSNotification.Name(rawValue: "DeletedCurrentSession"), object: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is ResultTableView {
            if scrollView.contentOffset.y < -70 {
                hideResultTable()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        hideResultTable()
    }
    
    private func setUpInitialLayout() {
        setUpScrambleTexTField()
        setUpSwipeRecognizers()
        // setUpResultTableViewFrame(withSize: view.frame.size)
        setUpSessionTableFrames()
        hideFABs()
        updateView()
        swipableView.isUserInteractionEnabled = true
        resultTableView.isUserInteractionEnabled = true
    }
    
    private func assignDelegates() {
        timerLabel.delegate = self
        resultTable.delegate = self
        resultTable.dataSource = data
        sessionTable.delegate = self
        sessionTable.dataSource = data
        sessionTextField.delegate = self
    }
    
    private func setUpSessionTableFrames() {
        view.addSubview(sessionTable)
        sessionTable.center = view.center
        sessionTable.transform = CGAffineTransform(translationX: 0, y: view.frame.height + 200)
        sessionTable.isHidden = true
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
    
    @objc func swipeUpDetected(_ sender: UISwipeGestureRecognizer) {
        showResultTable()
    }
    
    @objc func swipeDownDetected(_ sender: UISwipeGestureRecognizer) {
        hideResultTable()
    }
    
    private func showResultTable() {
        resultTableIsShown = true
        UIView.animate(withDuration: 0.4) {
            self.resultTable.transform = CGAffineTransform.init(translationX: 0, y: 25)
            self.resultTableView.transform = CGAffineTransform.init(translationX: 0, y: -self.resultTableView.frame.minY)
        }
    }
    
    private func hideResultTable() {
        resultTableIsShown = false
        UIView.animate(withDuration: 0.4) {
            self.resultTableView.transform = .identity
            self.resultTable.transform = .identity
        }
    }
    
    private func setUpResultTableViewFrame(withSize size: CGSize) {
        resultTableView.frame = CGRect(x: 0, y: size.height - 100, width: size.width, height: size.height)
        view.addSubview(resultTableView)
    }
    
    func appendNewSolve() {
        let currentSolve = data.requestSolve()
        currentSolve.time = timerLabel.time
        currentSolve.scramble = scrambleFilter + scrambleTextField.text!
        currentSolve.edgeMemo = edgeMemoLabel.text!
        currentSolve.cornerMemo = cornerMemoLabel.text!
        currentSolve.edgeFlips = ""
        currentSolve.cornerTwists = ""
        currentSolve.date = Date()
        currentSolve.penalty = 0
        data.append(solve: currentSolve)
    }
    
    private var scrambleFilter: String {
        if isCasual || UserSetting.shared.encoder.scrambleInWCAOrientation {
            return ""
        }
        let tempCube = Cube()
        return toString(tempCube.rotate(top: UserSetting.shared.general.topFaceColor, front: UserSetting.shared.general.frontFaceColor))
    }
    
    private func updateCube (withScramble scramble: String) {
        let topColor = UserSetting.shared.general.topFaceColor
        let frontColor = UserSetting.shared.general.frontFaceColor
        if isCasual || UserSetting.shared.encoder.scrambleInWCAOrientation {
            cubeView.cube = Cube(top: .WHITE, front: .GREEN, scramble: scramble)
        } else {
            cubeView.cube = Cube(top: topColor, front: frontColor, scramble: scramble)
        }
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
        edgeMemoLabel.text = LocalizationGeneral.timerMessage1.localized
        cornerMemoLabel.text = LocalizationGeneral.timerMessage2.localized
        memoIsShown = false
        if !isCasual {
            manuallyEnterTimeButton.imageView?.image = #imageLiteral(resourceName: "Show")
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        updateView()
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
