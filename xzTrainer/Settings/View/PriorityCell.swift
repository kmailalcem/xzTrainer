//
//  PriorityCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class PriorityCell: UITableViewCell {
    @IBOutlet weak var startingLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    func configureCell(startingLetter: String, secondLetters: String) {
        startingLabel.text = startingLetter
        secondLabel.text = secondLetters
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.937254902, alpha: 1)
        } else {
            contentView.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
        }
    }
}
