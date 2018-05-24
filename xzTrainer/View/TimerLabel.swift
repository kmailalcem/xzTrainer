//
//  TimerView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/18/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

public class TimerLabel: UILabel, UIGestureRecognizerDelegate {

    private var timer: Timer?
    private var isTiming: Bool = false
    private var startTime: TimeInterval = 0
    var delegate: TimerLabelDelegate?
    
    var time: Double {
        return Double(Date.timeIntervalSinceReferenceDate - startTime)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        // default properties
        text = "Time"
        textAlignment = .center
        textColor = UIColor(red: 0xe5/255, green: 0xe9/255, blue: 0xef/255, alpha: 1)
        font = font.withSize(50)
        
        // gesture recognizers
        isUserInteractionEnabled = true
        let holdRecognizer = UILongPressGestureRecognizer(
            target: self, action: #selector(TimerLabel.timerReady))
        holdRecognizer.minimumPressDuration = 0.55
        holdRecognizer.delegate = self
        
        let tapRecognizer = UILongPressGestureRecognizer(
            target: self, action: #selector(TimerLabel.timerTaped))
        tapRecognizer.minimumPressDuration = 0
        
        addGestureRecognizer(holdRecognizer)
        addGestureRecognizer(tapRecognizer)
    }
    
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc private func timerTaped(sender: UILongPressGestureRecognizer) {
        if (!isTiming) {
            if sender.state == .began {
                textColor = UIColor(red: 0x92/255, green: 0xa6/255, blue: 0xbe/255, alpha: 1)
            } else if sender.state == .ended {
                textColor = UIColor(red: 0xe5/255, green: 0xe9/255, blue: 0xef/255, alpha: 1)
            }
        } else {
            if sender.state == .began {
                timer?.invalidate()
                updateTimer()
                textColor = UIColor(red: 0xe5/255, green: 0xe9/255, blue: 0xef/255, alpha: 1)
                isTiming = false
                delegate?.timerDidFinish(self)
            }
        }
    }

    @objc func timerReady(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            text = "Ready"
            textColor = UIColor(red: 0xa3/255, green: 0xff/255, blue: 0x90/255, alpha: 1)
            isTiming = true
        } else if sender.state == .ended {
            startTime = Date().timeIntervalSinceReferenceDate
            timer = Timer.scheduledTimer(timeInterval: 0.053, target: self, selector: #selector(TimerLabel.updateTimer), userInfo: nil, repeats: true)
            textColor = UIColor(red: 0xe5/255, green: 0xe9/255, blue: 0xef/255, alpha: 1)
            delegate?.timerDidStart(self)
        }
    }
    
    @objc func updateTimer() {
        text = String(format: "%.3f", time)
    }
}

// used for informing the client when the timer starts and finishes
public protocol TimerLabelDelegate {
    func timerDidStart(_ sender: TimerLabel)
    func timerDidFinish(_ sender: TimerLabel)
}
