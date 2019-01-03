//
//  ResultTableView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ResultView: UIView {
    @IBOutlet weak var resultTable: ResultTableView!
    @IBOutlet weak var swipableView: RoundedView!
    @IBOutlet weak var resultTableTriggerButton: UIButton!
    @IBOutlet weak var sessionSelectionButton: UIButton!
    var tableIsShown = false
    var cumulativeTranslation: CGFloat = 0
    var originalPosition: CGPoint!
    var currentPositionTouched: CGPoint!
    
    func commonInit(tableDelegate: UITableViewDelegate) {
        themeSetUp()
        becomeObserver()
        sessionSelectionButton.setTitle(GlobalData.shared.currentSessionName, for: .normal)
        resultTable.delegate = tableDelegate
        resultTable.dataSource = GlobalData.shared
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ResultView.handlePan))
        // allows table view cells to be swiped separate from the view
        resultTableTriggerButton.addGestureRecognizer(gestureRecognizer)
        
        sessionSelectionButton.addTarget(tableDelegate, action: #selector(TimerVC.sessionTablePopIn), for: .touchUpInside)
        setUpFrame()
    }
    
    private func themeSetUp() {
        isUserInteractionEnabled = true
        backgroundColor = .clear
        tintColor = Theme.current.backgroundTintColor
        resultTable.backgroundColor = .clear
        swipableView.isUserInteractionEnabled = true
        swipableView.backgroundColor = Theme.current.darkerBackgroundColor
        swipableView.shadowRadius = 8
        swipableView.shadowOpacity = Float(Theme.current.shadowOpacity / 2)
    }
    
    private func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ResultView.sessionSelected), name: NSNotification.Name(rawValue: "SessionSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ResultView.updateSessionName), name: NSNotification.Name(rawValue: "SessionNameNeedsUpdate"), object: nil)
    }
    
    @objc func sessionSelected (_ notification: NSNotification) {
        resultTable.reloadData()
        sessionSelectionButton.setTitle(GlobalData.shared.currentSessionName, for: .normal)
    }
    
    @objc func updateSessionName (_ notification: NSNotification) {
        sessionSelectionButton.setTitle(GlobalData.shared.currentSessionName, for: .normal)
    }
    
    private func setUpFrame() {
        let superFrame = superview!.frame
        var heightOffset = superFrame.maxY - 100
        
        // cannot show full first entry when the iPhone is landscape
        if UIDevice.current.orientation.isLandscape && UIDevice.current.model == "iPhone" {
            heightOffset = superFrame.maxY - 20
        }
        frame = CGRect(x: 0, y: heightOffset, width: superFrame.width, height: superFrame.height)
        originalPosition = center
    }
    
    @objc func handlePan(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .changed:
            frame.origin = CGPoint(
                x: frame.origin.x,
                y: panGesture.location(in: superview!).y
            )
        case .ended:
            let velocity = panGesture.velocity(in: self)
            if panIsAggresive(forVelocity: velocity) {
                showResultTable(velocity: velocity.y / (frame.minY - superview!.frame.minY))
            } else {
                hideResultTable()
            }
        default:
            break
        }
    }
    
    private func panIsAggresive(forVelocity velocity: CGPoint) -> Bool {
        return center.y - originalPosition.y <= -150 || velocity.y <= -1200
    }
    
    @IBAction func resultTableTriggered() {
        if tableIsShown {
            hideResultTable()
        } else {
            showResultTable(velocity: 0)
        }
    }
    
    func hideResultTable() {
        tableIsShown = false
        UIView.animate(withDuration: 0.4) {
            self.center = self.originalPosition
        }
    }

    func showResultTable(velocity: CGFloat) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity, options: [.curveEaseInOut], animations: {
            self.center = self.superview!.center
        }) { (_) in
            self.tableIsShown = true
        }
    }
    
}
