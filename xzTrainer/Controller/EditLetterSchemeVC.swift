//
//  EditLetterSchemeVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/7/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class EditLetterSchemeVC: UIViewController {
    
    @IBOutlet weak var leftFace: UIView!
    @IBOutlet weak var rightFace: UIView!
    @IBOutlet weak var backFace: UIView!
    @IBOutlet weak var frontFace: UIView!
    @IBOutlet weak var topFace: UIView!
    @IBOutlet weak var bottomFace: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let colorScheme = UserSetting.shared.general.colorScheme
        let topColor = UserSetting.shared.general.topFaceColor
        let frontColor = UserSetting.shared.general.frontFaceColor
        
        topFace.backgroundColor = UIColor(cgColor: colorScheme.scheme[topColor]!)
        frontFace.backgroundColor = UIColor(cgColor: colorScheme.scheme[frontColor]!)
        leftFace.backgroundColor = UIColor(cgColor:
            colorScheme.scheme[leftSideColor(top: topColor, front: frontColor)]!)
        rightFace.backgroundColor = UIColor(cgColor: colorScheme.scheme[rightSideColor(top: topColor, front: frontColor)]!)
        bottomFace.backgroundColor = UIColor(cgColor:
            colorScheme.scheme[oppositeColor(topColor)]!)
        backFace.backgroundColor = UIColor(cgColor:
            colorScheme.scheme[oppositeColor(frontColor)]!)
        
        let letterScheme = UserSetting.shared.general.letterScheme
        for i in 0..<NUM_STICKERS {
            let edgeButton = view.viewWithTag(i + 1) as! UIButton
            edgeButton.setTitle(letterScheme.edgeScheme[EdgePosition(rawValue: i)!]!, for: .normal)
            let cornerButton = view.viewWithTag(i + 1 + NUM_STICKERS) as! UIButton
            cornerButton.setTitle(letterScheme.cornerScheme[CornerPosition(rawValue: i)!]!, for: .normal) 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
