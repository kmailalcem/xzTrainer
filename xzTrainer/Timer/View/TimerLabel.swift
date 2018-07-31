//
//  TimerView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/18/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

public class TimerLabel: UILabel, UIGestureRecognizerDelegate {

    static let defaultColor = #colorLiteral(red: 0.003921568627, green: 0.2196078431, blue: 0.3921568627, alpha: 1)
    static let beginTappingColor = #colorLiteral(red: 0.4078431373, green: 0.5176470588, blue: 0.6431372549, alpha: 1)
    static let readyColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    var timer: Timer?
    private var isTiming: Bool = false
    private var startTime: TimeInterval = 0
    private var endTime: TimeInterval = 0
    var delegate: TimerLabelDelegate?
    
    var time: Double {
        return Double(endTime - startTime)
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
        textColor = TimerLabel.defaultColor
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
    
    public func startTimer(delay: Double) {
        startTime = Date().timeIntervalSinceReferenceDate + delay
        timer = Timer.scheduledTimer(timeInterval: 0.053, target: self, selector: #selector(TimerLabel.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func timerTaped(sender: UILongPressGestureRecognizer) {
        if (!isTiming) {
            if sender.state == .began {
                textColor = TimerLabel.beginTappingColor
            } else if sender.state == .ended {
                textColor = TimerLabel.defaultColor
            }
        } else {
            if sender.state == .began {
                timer?.invalidate()
                updateTimer()
                textColor = TimerLabel.defaultColor
                isTiming = false
                endTime = Date.timeIntervalSinceReferenceDate
                delegate?.timerDidFinish(self)
            }
        }
    }

    @objc func timerReady(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            delegate?.timerWillStart(self)
            text = "Ready"
            textColor = TimerLabel.readyColor
            isTiming = true
        } else if sender.state == .ended {
            delegate?.timerDidStart(self)
        }
    }
    
    @objc func updateTimer() {
        endTime = Date.timeIntervalSinceReferenceDate
        text = time < 0 ? "React" : convertTimeDoubleToString(time)
    }
    
    @objc func manuallyEntered(time: Double) {
        endTime = startTime + time
    }
}

// used for informing the client when the timer starts and finishes
public protocol TimerLabelDelegate {
    func timerDidStart(_ sender: TimerLabel)
    func timerDidFinish(_ sender: TimerLabel)
}

public extension TimerLabelDelegate {
    func timerWillStart(_ sender: TimerLabel) {}
    func timerWillFinish(_ sender: TimerLabel) {}
}
