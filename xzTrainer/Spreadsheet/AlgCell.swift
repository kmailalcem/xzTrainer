//
//  AlgCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/5/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class AlgCell: UITableViewCell {

    @IBOutlet weak var cycleLabel: ThemeHeader1!
    @IBOutlet weak var algLabel: ThemeText!
    
    @IBOutlet weak var assocLabel: ThemeSubtext!
    
    func configureCell(cycle: String, alg: String, association: String) {
        cycleLabel.text = cycle
        algLabel.text = alg
        assocLabel.text = association
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
