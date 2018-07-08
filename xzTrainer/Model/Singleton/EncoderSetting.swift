//
//  MemoSettings.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class EncoderSetting {
    
    private var preferenceList = PreferenceList()
    
    var userPreference: PreferenceList {
        get {
            userMemoStyle.sort { (lhs, rhs) -> Bool in
                lhs.preference > rhs.preference
            }
            for preference in userMemoStyle {
                preferenceList.prefers(preference.preferredEdgesAsFirstLetter)
                preferenceList.prefers(preference.preferredEdgesAsFirstLetter)
                preferenceList.avoids(preference.avoidedEdgesAsFirstLetter)
                preferenceList.avoids(preference.avoidedCornersAsFirstLetter)
            }
            return preferenceList
        }
    }
    var advancedParity = AdvancedParity()
    var userMemoStyle: [MemoPreference] = []
    
    public func activateSetting(_ memoPreference: MemoPreference) {
        userMemoStyle.append(memoPreference)
    }
}

class AdvancedParity {
    var isEnabled = true
    var isActivated = true
    // default to Old Pochmann parity pieces
    var parityEdgePiece1 = EdgeSticker.UL
    var parityEdgePiece2 = EdgeSticker.UB
}

protocol MemoPreference {
    var preferredEdgesAsFirstLetter: [EdgePosition] { get }
    var preferredCornersAsSecondLetter: [CornerPosition] { get }
    var avoidedEdgesAsFirstLetter: [EdgePosition] { get }
    var avoidedCornersAsFirstLetter: [CornerPosition] { get }
    var preferredEdgesAsSecondLetter: [EdgePosition: [EdgePosition]] { get }
    var preferredcornersAsSecondLetter: [EdgePosition: [EdgePosition]] { get }
    var avoidedEdgesAsSecondLetter: [CornerPosition: [CornerPosition]] { get }
    var avoidedCornersAsSecondLetter: [CornerPosition: [CornerPosition]] { get }
    var preference: Int { get }
}
