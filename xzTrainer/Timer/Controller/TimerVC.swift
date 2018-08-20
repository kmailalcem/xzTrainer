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

class TimerVC: ThemeViewController {
    // determines the mode of the timer
    var isCasual: Bool = true
    
    // what is seen on the screen
    @IBOutlet weak var dismissPopUpButton: UIButton!
    @IBOutlet weak var scrambleTextField: UILabel!
    @IBOutlet weak var cubeView: CubeView!
    @IBOutlet weak var timerLabel: TimerLabel!
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var memoStack: UIStackView!
    @IBOutlet weak var modeTitleLabel: UILabel!
    
    // the table that swipes up and down
    var resultTableView = Bundle.main.loadNibNamed("ResultView", owner: self, options: nil)?.first as! ResultView

    // Floating Action Buttons
    @IBOutlet weak var floatingPlus: FloatingActionButton!
    @IBOutlet weak var inTimerSettingButton: FloatingActionButton!
    @IBOutlet weak var nextScrambleButton: FloatingActionButton!
    @IBOutlet weak var manuallyEnterTimeButton: FloatingActionButton!
    
    // result/penalty pop up view
    var popUpDetailView = Bundle.main.loadNibNamed("ResultPopUpView", owner: self, options: nil)?.first as! ResultPopUpView
    
    // select sessions
    var sessionTable: SessionView!
    
    // booleans to track UI
    var floatingPlusIsPressed: Bool = false
    var memoIsShown = false
    
    let data = GlobalData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoStack.isHidden = isCasual
        modeTitleLabel.text = isCasual ? LocalizableMode.casualBLD.localized : LocalizableMode.executionTraining.localized
        
        cubeView.settingFrame()
        setUpInitialLayout()
        assignDelegates()
    
        view.addSubview(resultTableView)
        resultTableView.commonInit(owner: self)
        resultTableView.resultTable.reloadData()
        popUpDetailView.rootViewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.reloadTable), name: NSNotification.Name(rawValue: "TimeUpdated"), object: nil)
    }
    
    @objc func reloadTable(_ notification: NSNotification) {
        resultTableView.resultTable.reloadData()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        hideResultTable()
    }
    
    private func setUpInitialLayout() {
        setUpScrambleTexTField()
        // setUpSwipeRecognizers()
        setUpSessionTableFrames()
        hideFABs()
        updateView()
        
        resultTableView.isUserInteractionEnabled = true
        
    }
    
    private func assignDelegates() {
        timerLabel.delegate = self
    }
    
    private func setUpSessionTableFrames() {
        sessionTable = SessionView(frame: view.frame)
        sessionTable.alpha = 0
        sessionTable.rootViewController = self
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
        // swipableView.addGestureRecognizer(swipeUpRecognizer)
        // swipableView.addGestureRecognizer(swipeDownRecognizer)
    }
    
    @objc func swipeUpDetected(_ sender: UISwipeGestureRecognizer) {
        showResultTable()
    }
    
    @objc func swipeDownDetected(_ sender: UISwipeGestureRecognizer) {
        hideResultTable()
    }
    
    private func showResultTable() {
        resultTableView.showResultTable()
    }
    
    private func hideResultTable() {
        resultTableView.hideResultTable()
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

extension TimerVC: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
}
