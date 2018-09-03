//
//  ThemeSelectionCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 9/3/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class ThemeSelectionCell: UITableViewCell {

    @IBOutlet var checkImage: UIImageView!
    @IBOutlet var themeName: UILabel!
    @IBOutlet var roundedView: RoundedView!
    var managedTheme = Theme.current
    var managedShadowOpacity = Theme.current.shadowOpacity
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        checkImage.isHidden = !selected
    }
    
    func configureCell(name: String, shadowOpacity: Float) {
        themeName.text = name
        themeName.textColor = Theme.current.normalTextColor
        roundedView.backgroundColor = Theme.current.backgroundColor
        roundedView.shadowOpacity = shadowOpacity
        managedShadowOpacity = Double(shadowOpacity)
        isSelected = managedShadowOpacity == Theme.current.shadowOpacity
    }
    
    func configureCell(name: String, theme: Theme) {
        themeName.text = name
        themeName.textColor = theme.headerTextColor
        roundedView.backgroundColor = theme.backgroundColor
        roundedView.shadowOpacity = Float(Theme.current.shadowOpacity)
        managedTheme = theme
        isSelected = managedTheme.name == Theme.current.name
    }
}
