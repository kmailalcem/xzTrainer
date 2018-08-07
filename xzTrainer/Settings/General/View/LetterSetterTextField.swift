//
//  LetterSetterTextField.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/9/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class LetterSetterTextField: UITextField {

    var isOverwide: Bool = false
    var managedEdgePosition: EdgePosition? = nil {
        didSet {
            text = UserSetting.shared.general.letterScheme.edgeScheme[managedEdgePosition!]
        }
    }
    
    var managedCornerPosition: CornerPosition? = nil {
        didSet {
            text = UserSetting.shared.general.letterScheme.cornerScheme[managedCornerPosition!]
        }
    }
    
}
