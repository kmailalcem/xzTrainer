//
//  MemoSettings.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class EncoderSetting {
    
    // when parity arise, switch certain edge pieces to cancel the parity
    var advancedParity = AdvancedParity()
}

class AdvancedParity {
    var isEnabled = true
    var isActivated = true
    // default to Old Pochmann parity pieces
    var parityEdgePiece1 = EdgeSticker.UL
    var parityEdgePiece2 = EdgeSticker.UB
}
