//
//  ModeSelectionCell.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/30/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ModeSelectionCell: UITableViewCell, ThemeElement {

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var gradientMask: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        becomeObserver()
        themeSetUp()
    }

    @objc func themeSetUp() {
        DispatchQueue.main.async {
            self.gradientMask.backgroundColor = Theme.current.invertedBackgroundColor.withAlphaComponent(0.75)
            self.roundedView.backgroundColor = Theme.current.invertedBackgroundColor
            self.roundedView.shadowOpacity = Float(Theme.current.shadowOpacity)
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            roundedView.backgroundColor = Theme.current.invertedBackgroundColor.withAlphaComponent(0.5)
            gradientMask.isHidden = true
            bgImage.isHidden = true
        } else {
            roundedView.backgroundColor = Theme.current.invertedBackgroundColor
            gradientMask.isHidden = false
            bgImage.isHidden = false
        }
    }
}
