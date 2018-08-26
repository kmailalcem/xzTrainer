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
        selectionStyle = .none
        let currentSolve = solveStats[index]
        indexLabel.text = String(index + 1)
        timeLabel.text = convertTimeDoubleToString(currentSolve.timeIncludingPenalty)
        
        ao5Label.text = String("ao5: \(convertTimeDoubleToString(currentSolve.ao5))" )
        
        ao12Label.text = String(format: "ao12: \(convertTimeDoubleToString(currentSolve.ao12))")
        
        scramble = currentSolve.scramble!
        backgroundColor = .clear
        roundedView.backgroundColor = Theme.current.invertedBackgroundColor
        roundedView.shadowOpacity = 0.125
        roundedView.shadowRadius = 3
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            roundedView.backgroundColor = Theme.current.darkerBackgroundColor
        } else {
            roundedView.backgroundColor = Theme.current.invertedBackgroundColor
        }
        
    }
}
