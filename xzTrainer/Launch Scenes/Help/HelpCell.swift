//
//  HelpCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/9/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class HelpCell: UITableViewCell {

    @IBOutlet weak var explainedFAB: UIImageView!
    @IBOutlet weak var fabContainerView: UIView!
    @IBOutlet weak var wikiName: UILabel!
    @IBOutlet weak var explanation: UILabel!
    
    func configureCell(helpedIcon: HelpedIcon) {
        explainedFAB.image = helpedIcon.image
        fabContainerView.layer.cornerRadius = 20
        fabContainerView.layer.shadowRadius = 3
        fabContainerView.layer.shadowOpacity = 0.25
        fabContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        wikiName.text = helpedIcon.wikiName
        explanation.text = helpedIcon.explanation
    }
}
