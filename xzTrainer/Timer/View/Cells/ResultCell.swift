//
//  ResultCell.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var ao5Label: UILabel!
    @IBOutlet var ao12Label: UILabel!
    @IBOutlet var indexLabel: UILabel!
    @IBOutlet var roundedView: RoundedView!
    var scramble: String = ""
    
    func configureCell(index: Int, solveStats: [Solve]) {
        let currentSolve = solveStats[index]
        indexLabel.text = String(index + 1)
        timeLabel.text = convertTimeDoubleToString(currentSolve.timeIncludingPenalty)
        
        ao5Label.text = String("ao5: \(convertTimeDoubleToString(currentSolve.ao5))" )
        
        ao12Label.text = String(format: "ao12: \(convertTimeDoubleToString(currentSolve.ao12))")
        
        scramble = currentSolve.scramble!
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            roundedView.backgroundColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
            ao5Label.textColor = #colorLiteral(red: 0.5843137255, green: 0.7176470588, blue: 0.7882352941, alpha: 1)
            ao12Label.textColor = #colorLiteral(red: 0.5843137255, green: 0.7176470588, blue: 0.7882352941, alpha: 1)
            indexLabel.textColor = #colorLiteral(red: 0.5843137255, green: 0.7176470588, blue: 0.7882352941, alpha: 1)
        } else {
            roundedView.backgroundColor = #colorLiteral(red: 0, green: 0.3289608657, blue: 0.5148260593, alpha: 1)
        }
        
    }
}
