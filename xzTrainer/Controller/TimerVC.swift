//
//  ViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, TimerLabelDelegate,  UIGestureRecognizerDelegate {
    
    
    // var swipeRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var scrambleTextField: UITextField!
    @IBOutlet var cubeView: CubeView!
    @IBOutlet var timerLabel: TimerLabel!
    
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
            print("segued")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        cubeView.cube = Cube(top: .WHITE, front: .GREEN, scramble: "R U R' U'")
        scrambleTextField.delegate = self
        timerLabel.delegate = self
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeDetected))
        swipeRecognizer.direction = .up
        view.addGestureRecognizer(swipeRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scrambleTextField.resignFirstResponder()
        let cube = cubeView.cube
        cube.reScrambleCube(scrambleTextField.text!)
        // print(scrambleTextField.text!)
        cubeView.cube = cube
        cubeView.updateFaces()
        return false
    }

    func timerDidStart(_ sender: TimerLabel) {
        print("Timing starts")
    }
    
    func timerDidFinish(_ sender: TimerLabel) {
        print("Timing ends")
    }
}

