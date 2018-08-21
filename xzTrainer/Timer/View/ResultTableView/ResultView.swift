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
    
    func commonInit(owner: TimerVC) {
        isUserInteractionEnabled = true
        sessionSelectionButton.setTitle("default", for: .normal)
        backgroundColor = .clear
        resultTable.backgroundColor = .clear
        
        // TimerVC manages all the views; not this one.
        resultTable.delegate = owner
        
        resultTable.dataSource = GlobalData.shared
        sessionSelectionButton.addTarget(owner, action: #selector(TimerVC.sessionTablePopIn), for: .touchUpInside)
        
        let superFrame = superview!.frame
        frame = CGRect(x: 0, y: superFrame.maxY - 100, width: superFrame.width, height: superFrame.height)
        NotificationCenter.default.addObserver(self, selector: #selector(ResultView.sessionSelected), name: NSNotification.Name(rawValue: "SessionSelected"), object: nil)
        swipableView.isUserInteractionEnabled = true
        swipableView.shadowRadius = 8
        swipableView.shadowOpacity = 0.125
    }
    
    @IBAction func resultTableTriggered() {
        if tableIsShown {
            hideResultTable()
        } else {
            showResultTable()
        }
    }
    
    func showResultTable() {
        tableIsShown = true
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform.init(translationX: 0, y: -self.frame.minY)
            self.resultTable.transform = CGAffineTransform.init(translationX: 0, y: 25)
        }
    }
    
    func hideResultTable() {
        tableIsShown = false
        UIView.animate(withDuration: 0.4) {
            self.transform = .identity
            self.resultTable.transform = .identity
        }
    }

    @objc func sessionSelected (_ notification: NSNotification) {
        resultTable.reloadData()
        if let sessionName = notification.userInfo?["selectedSessionName"] as? String {
            sessionSelectionButton.setTitle(sessionName, for: .normal)
        }
    }
    
}
