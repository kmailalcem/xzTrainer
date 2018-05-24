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
    var scramble: String = ""
    
    func configureCell(index: Int, solveStats: [SolveTime]) {
        indexLabel.text = String(index + 1)
        timeLabel.text = String(format: "%.3f", solveStats[index].time)
        
        if let ao5 = solveStats.ao(5, ending: index + 1) {
            ao5Label.text = String(format: "ao5: %.3f", ao5)
        } else {
            ao5Label.text = "ao5: N/A"
        }
        
        if let ao12 = solveStats.ao(12, ending: index + 1) {
            ao12Label.text = String(format: "ao12: %.3f", ao12)
        } else {
            ao12Label.text = "ao12: N/A"
        }
        
        scramble = solveStats[index].scramble
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
