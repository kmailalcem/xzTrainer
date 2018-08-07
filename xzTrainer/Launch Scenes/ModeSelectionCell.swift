//
//  ModeSelectionCell.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/30/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ModeSelectionCell: UITableViewCell {

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var gradientMask: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layer = CAGradientLayer()
        
        layer.colors = [#colorLiteral(red: 0.03529411765, green: 0.3333333333, blue: 0.5058823529, alpha: 0.3479773116).cgColor, #colorLiteral(red: 0.03424261117, green: 0.3302167863, blue: 0.5046529747, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x:1, y: 0.5)
        layer.frame = gradientMask.frame
        layer.cornerRadius = 15
        gradientMask.layer.addSublayer(layer)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            roundedView.backgroundColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
            gradientMask.isHidden = true
            bgImage.isHidden = true
        } else {
            roundedView.backgroundColor = #colorLiteral(red: 0, green: 0.3289608657, blue: 0.5148260593, alpha: 1)
            gradientMask.isHidden = false
            bgImage.isHidden = false
        }
    }
}
