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
    var managedPiece: CubePiece! {
        didSet {
            text = UserSetting.shared.general.letterScheme[managedPiece]
        }
    }
    
}
