//
//  ResultCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/20/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
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
        timeLabel.text = String(format: "%.3f", currentSolve.time)
        
        if currentSolve.ao5 != -1 {
            ao5Label.text = String(format: "ao5: %.3f", currentSolve.ao5)
        } else {
            ao5Label.text = "ao5: N/A"
        }
        
        if  currentSolve.ao12 != -1 {
            ao12Label.text = String(format: "ao12: %.3f", currentSolve.ao12)
        } else {
            ao12Label.text = "ao12: N/A"
        }
        
        scramble = currentSolve.scramble!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        selectAnimation()
    }
    
    func selectAnimation() {
        roundedView.backgroundColor = UIColor.white
        roundedView.alpha = 0.2
        UIView.animate(withDuration: 0.1, animations: {
            self.roundedView.backgroundColor = #colorLiteral(red: 0, green: 0.3289608657, blue: 0.5148260593, alpha: 1)
            self.roundedView.alpha = 1
            })
    }
}
