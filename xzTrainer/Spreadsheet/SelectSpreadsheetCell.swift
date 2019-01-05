//
//  SelectSpreadsheetCell.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/4/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SelectSpreadsheetCell: ThemeCell {

    @IBOutlet weak var sheetName: ThemeHeader1!
    
    func configureCell(name: String) {
        sheetName.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
