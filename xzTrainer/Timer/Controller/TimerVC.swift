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
    @IBOutlet weak var timerLabel: TimerLabel!
    @IBOutlet weak var modeTitleLabel: UILabel!
    
    // cube + scramble + memo
    @IBOutlet weak var detailCubeView: DetailCubeView!
    
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
    var memoIsShown = false
    
    let data = GlobalData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeTitleLabel.text = isCasual ? LocalizableMode.casualBLD.localized : LocalizableMode.executionTraining.localized
        
        setUpInitialLayout()
        assignDelegates()
    
        popUpDetailView.rootViewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerVC.reloadTable), name: NSNotification.Name(rawValue: "TimeUpdated"), object: nil)
        
    }
    
    var isInitialEntry = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isInitialEntry {
            isInitialEntry = false
            updateView()
        }
    }
    
    @objc func reloadTable(_ notification: NSNotification) {
        resultTableView.resultTable.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        resultTableView.hideResultTable()
    }
    
    private func setUpInitialLayout() {
        setUpSessionTableFrames()
        setUpResultTableFrames()
        hideFABs()
        
    }
    
    private func assignDelegates() {
        timerLabel.delegate = self
    }
    
    private func setUpSessionTableFrames() {
        sessionTable = SessionView(frame: view.frame)
        sessionTable.alpha = 0
        sessionTable.rootViewController = self
    }
    
    private func setUpResultTableFrames() {
        view.addSubview(resultTableView)
        resultTableView.commonInit(owner: self)
        resultTableView.resultTable.reloadData()
    }
    
    @objc func sessionTablePopIn() {
        view.addSubview(sessionTable)
        sessionTable.center = view.center
        sessionTable.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.2) {
            self.sessionTable.alpha = 1
            self.sessionTable.transform = .identity
        }
    }
    
    func appendNewSolve() {
        let currentSolve = data.requestSolve()
        currentSolve.time = timerLabel.time
        
        //TODO: make this nicer
        currentSolve.scramble = scrambleFilter + detailCubeView.scrambleLabel.text!
        currentSolve.edgeMemo = detailCubeView.edgeMemoLabel.text!
        currentSolve.cornerMemo = detailCubeView.cornerMemoLabel.text!

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
    
    @IBAction func updateView() {
        detailCubeView.memoDisplayMode = isCasual ? .none : .hidden
        detailCubeView.updateView()
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
