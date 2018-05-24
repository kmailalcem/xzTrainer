//
//  ViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class TimerVC: UIViewController, UITextFieldDelegate, TimerLabelDelegate,  UIGestureRecognizerDelegate {
    
    // var swipeRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var scrambleTextField: UITextField!
    @IBOutlet var cubeView: CubeView!
    @IBOutlet var timerLabel: TimerLabel!
    var userSolves: [SolveTime] = []
    
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
    
    @objc func swipeDetected(_ sender: UISwipeGestureRecognizer) {
        print("swipe detected")
        //if let swipeRecognizer = sender as? UISwipeGestureRecognizer {
            performSegue(withIdentifier: "timerToTableSegue", sender: nil)
        //}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ResultTableVC {
            destination.userSolves = userSolves
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        cubeView.cube = Cube(top: .WHITE, front: .GREEN, scramble: "")
        scrambleTextField.delegate = self
        scrambleTextField.borderStyle = .none
        timerLabel.delegate = self
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TimerVC.swipeDetected))
        swipeRecognizer.direction = .up
        view.addGestureRecognizer(swipeRecognizer)
        
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scrambleTextField.resignFirstResponder()
        updateCube(withScramble: scrambleTextField.text!)
        return false
    }

    func timerDidStart(_ sender: TimerLabel) {
        print("Timing starts")
    }
    
    func timerDidFinish(_ sender: TimerLabel) {
        userSolves.append(SolveTime(time: timerLabel.time,
                                    scramble: scrambleTextField.text!))
        updateView()
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
    }
}

