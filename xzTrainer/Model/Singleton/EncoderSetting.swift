//
//  MemoSettings.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

func keyExists(_ key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

class EncoderSetting {
    
    private var preferenceList = PreferenceList()
    
    var userPreference: PreferenceList {
        get {
            userMemoStyle.sort { (lhs, rhs) -> Bool in
                lhs.priority > rhs.priority
            }
            for preference in userMemoStyle {
                let temp = preference.preferredFirstEdge
                preferenceList.prefers(temp)
                preferenceList.prefers(preference.preferredFirstCorner)
                preferenceList.avoids(preference.avoidedFirstEdge)
                preferenceList.avoids(preference.avoidedFirstCorner)
            }
            return preferenceList
        }
    }
    
    var advancedParity = AdvancedParity()
    var userMemoStyle: [MemoPreference] = []
    
    public func activateSetting(_ memoPreference: MemoPreference) {
        let memoKey = type(of: memoPreference).memoKey
        UserDefaults.standard.set(true, forKey: memoKey)
        userMemoStyle.append(memoPreference)

    }
    
    public func deactivateSetting(_ memoPreference: MemoPreference) {
        for i in 0 ..< userMemoStyle.count {
            if type(of: userMemoStyle[i]) == type(of: memoPreference) {
                userMemoStyle.remove(at: i)
                UserDefaults.standard.set(false, forKey: type(of: memoPreference).memoKey)
                break
            }
        }
    }
    
    init() {
        for style in allMemoStyles {
            let memoKey = type(of: style).memoKey
            if UserDefaults.standard.object(forKey: memoKey) != nil && UserDefaults.standard.bool(forKey: memoKey) {
                userMemoStyle.append(style)
            }
        }
    }
}

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

protocol MemoPreference {
    static var memoKey: String { get }
    var priority: Int { get }
    var preferredFirstEdge: [EdgePosition] { get }
    var preferredFirstCorner: [CornerPosition] { get }
    var avoidedFirstEdge: [EdgePosition] { get }
    var avoidedFirstCorner: [CornerPosition] { get }
}

extension MemoPreference {
    var priority: Int { get { return 0 } }
    
    var preferredFirstEdge: [EdgePosition] { get { return [] } }
    
    var preferredFirstCorner: [CornerPosition] { get { return [] } }
    
    var avoidedFirstEdge: [EdgePosition] { get { return [] } }
    
    var avoidedFirstCorner: [CornerPosition] { get { return [] } }
    
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        return []
    }
    
    func preferredSecondCorner(for first: CornerPosition) -> [CornerPosition] {
        return []
    }
    
    func avoidedSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        return []
    }
    
    func avoidedSecondCorner(for first: CornerPosition) -> [CornerPosition] {
        return []
    }
}

let allMemoStyles: [MemoPreference] = [
    MemoGeneral(),
    PreferTrivial(),
    AvoidMisorientedEdge(),
    PreferCornerWithShortSetUp(),
    UseUFL(),
    PreferSameOuterLayerCommutator(),
    PreferSameInnerLayerCommutator(),
    PreferCrossLayerCommutator(),
    Prefer1MoveSetUp()
]

class MemoGeneral: MemoPreference {
    static var memoKey: String = "general"
}

class PreferTrivial: MemoPreference {
    static var memoKey: String = "PreferTrivial"
    
    var priority: Int = 100
    var preferredFirstEdge: [EdgePosition] {
        get {
            return [.UB, .UF, .DB]
        }
    }
}

class AvoidMisorientedEdge : MemoPreference {
    static var memoKey: String = "AvoidMisorientedEdge"
    
    var avoidedFirstEdge: [EdgePosition] = [.FU, .BD, .LB, .LD, .LF, .LU, .RB, .RD, .RF, .RU]
}

class PreferCornerWithShortSetUp: MemoPreference {
    static var memoKey: String = "PreferCornerWithShortSetUp"
    
    var preferredFirstCorner: [CornerPosition] = [.RDF, .BDR, .LDB, .FLU, .URF, .LUF, .DLF, .RBD, .RUB, .RFU]
}

class UseUFL: MemoPreference {
    static var memoKey: String = "UseUFL"
    
    var preferredFirstCorner: [CornerPosition] = [.UFL, .RFU, .DFR, .LFD]
}

class PreferSameOuterLayerCommutator: MemoPreference {
    static var memoKey: String = "PreferSameOuterLayerCommutator"
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        if EdgeSticker.leftOuterLayerPieces.contains(first) {
            return EdgeSticker.leftOuterLayerPieces
        }
        if EdgeSticker.rightOuterLayerPieces.contains(first) {
            return EdgeSticker.rightOuterLayerPieces
        }
        return []
    }
}

class PreferSameInnerLayerCommutator: MemoPreference {
    static var memoKey: String = "PreferSameInnerLayerCommutator"
    
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        if EdgeSticker.leftInnerLayerPieces.contains(first) {
            return EdgeSticker.leftInnerLayerPieces
        }
        if EdgeSticker.rightInnerLayerPieces.contains(first) {
            return EdgeSticker.rightInnerLayerPieces
        }
        return []
    }
}

class PreferCrossLayerCommutator: MemoPreference {
    static var memoKey: String = "PreferCrossLayerCommutator"
    
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        if EdgeSticker.leftOuterLayerPieces.contains(first) {
            return EdgeSticker.rightOuterLayerPieces
        }
        if EdgeSticker.rightOuterLayerPieces.contains(first) {
            return EdgeSticker.leftOuterLayerPieces
        }
        return []
    }
}

class Prefer1MoveSetUp: MemoPreference {
    static var memoKey: String = "Prefer1MoveSetUp"
    var preferredFirstEdge: [EdgePosition] = [.UB, .UL, .UR, .UF, .RB, .LB, .DB]
}
