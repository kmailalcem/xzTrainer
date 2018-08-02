//
//  AdvancedParity.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class AdvancedParity {
    static let enabledKey = "AdvancedParityEnabledKey"
    static let firstEdgeKey = "AdvancedParityEdge1"
    static let secondEdgeKey = "AdvancedParityEdge2"
    
    // enabled means that user wants to enable this feature
    var isEnabled = false {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: AdvancedParity.enabledKey)
        }
    }
    // activated means that a parity actually exists
    var isActivated = true
    // default to Old Pochmann parity pieces
    var parityEdgePiece1 = EdgeSticker.UL {
        didSet {
            UserDefaults.standard.set(parityEdgePiece1.rawValue, forKey: AdvancedParity.firstEdgeKey
            )
        }
    }
    var parityEdgePiece2 = EdgeSticker.UB {
        didSet {
            UserDefaults.standard.set(parityEdgePiece2.rawValue, forKey: AdvancedParity.secondEdgeKey
            )
        }
    }
    
    init() {
        if keyExists(AdvancedParity.enabledKey) {
            isEnabled = UserDefaults.standard.bool(forKey: AdvancedParity.enabledKey)
        }
        
        if keyExists(AdvancedParity.firstEdgeKey) {
            let rawValue = UserDefaults.standard.integer(forKey: AdvancedParity.firstEdgeKey)
            parityEdgePiece1 = EdgeSticker(rawValue: rawValue)!
        }
        
        if keyExists(AdvancedParity.secondEdgeKey) {
            let rawValue = UserDefaults.standard.integer(forKey: AdvancedParity.secondEdgeKey)
            parityEdgePiece2 = EdgeSticker(rawValue: rawValue)!
        }
    }
}
