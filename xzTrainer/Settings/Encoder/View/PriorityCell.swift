//
//  PriorityCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class PriorityCell: ThemeCell {
    @IBOutlet weak var startingLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    func configureCell(startingLetter: String, secondLetters: String) {
        startingLabel.text = startingLetter
        secondLabel.text = secondLetters
    }
    
}
