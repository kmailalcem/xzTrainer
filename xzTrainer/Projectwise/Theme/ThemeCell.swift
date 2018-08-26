//
//  ThemeCell.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 8/2/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = Theme.current.lighterBackgroundColor
        } else {
            contentView.backgroundColor = UIColor.clear
        }
    }
}
