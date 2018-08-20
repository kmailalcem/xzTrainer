//
//  SessionCell.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/21/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {

    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var cellBackground: RoundedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackground.layer.borderWidth = 1
        cellBackground.layer.borderColor = sessionNameLabel.textColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
