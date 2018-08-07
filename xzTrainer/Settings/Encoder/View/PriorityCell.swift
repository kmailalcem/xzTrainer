//
//  PriorityCell.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 8/1/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
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
