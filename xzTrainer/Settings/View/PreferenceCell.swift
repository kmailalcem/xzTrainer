//
//  PreferenceCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/31/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class PreferenceCell: UITableViewCell {
    
    @IBOutlet weak var startingLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!

    func configureCell(startingLetter: String, secondLetters: String, isPreferringMethod: Bool) {
        startingLabel.text = startingLetter
        secondLabel.text = secondLetters
        if !isPreferringMethod {
            secondLabel.textColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
        }
    }
    
    
}
