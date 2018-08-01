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

fileprivate func edge(_ piece: EdgeSticker) -> String {
    if UserSetting.shared.general.letterScheme.edgeScheme[piece]!.count == 0 {
        return toString(piece)
    }
    return toString(piece) + "/\(UserSetting.shared.general.letterScheme.edgeScheme[piece]!)"
}

fileprivate func corner(_ piece: CornerSticker) -> String {
    if UserSetting.shared.general.letterScheme.cornerScheme[piece]!.count == 0 {
        return toString(piece)
    }
    return toString(piece) + "/\(UserSetting.shared.general.letterScheme.cornerScheme[piece]!)"
}

class EncoderSetting {
    
    private var preferenceList = PreferenceList()
    
    var userPreference: PreferenceList {
        get {
            userMemoStyle.sort { (lhs, rhs) -> Bool in
                lhs.priority < rhs.priority
            }
            for preference in userMemoStyle {
                let temp = preference.preferredFirstEdge
                preferenceList.prefers(temp)
                preferenceList.prefers(preference.preferredFirstCorner)
                preferenceList.avoids(preference.avoidedFirstEdge)
                preferenceList.avoids(preference.avoidedFirstCorner)
            }
            preferenceList.reloadSecondLetters()
            for preference in userMemoStyle {
                for i in 0 ..< NUM_STICKERS {
                    let edge = EdgeSticker(rawValue: i)!
                    let corner = CornerSticker(rawValue: i)!
                    preferenceList.prefers(preference.preferredSecondEdge(for: edge), forStarting: edge)
                    preferenceList.prefers(preference.preferredSecondCorner(for: corner), forStarting: corner)
                    preferenceList.avoids(preference.avoidedSecondEdge(for: edge), forStarting: edge)
                    preferenceList.avoids(preference.avoidedSecondCorner(for: corner), forStarting: corner)
                }
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
    static var description: String { get }
    static var explanation: String { get }
    var isEdgeMethod: Bool { get }
    var isPreferringMethod: Bool { get }
    var priority: Int { get }
    var preferredFirstEdge: [EdgePosition] { get }
    var preferredFirstCorner: [CornerPosition] { get }
    var avoidedFirstEdge: [EdgePosition] { get }
    var avoidedFirstCorner: [CornerPosition] { get }
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition]
    func preferredSecondCorner(for first: CornerPosition) -> [CornerPosition]
    func avoidedSecondEdge(for first: EdgePosition) -> [EdgePosition]
    func avoidedSecondCorner(for first: CornerPosition) -> [CornerPosition]
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
    PreferTrivial(),
    AvoidMisorientedEdge(),
    PreferCornerWithShortSetUp(),
    UseUFL(),
    PreferSameOuterLayerCommutator(),
    PreferSameInnerLayerCommutator(),
    PreferCrossLayerCommutator(),
    Prefer1MoveSetUp()
]

class PreferTrivial: MemoPreference {
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer easy edge stickers (\(edge(.UB)), \(edge(.UF)), \(edge(.DB)))"
    
    static var explanation: String = "\(edge(.UB)) can be solved in only 1 move. \(edge(.UF)), \(edge(.DB)) can be solved in 4 moves by U2 M' U2 M' or M U2 M U2. Turn on this switch so that these pieces are chosen as cycle break over others."
    
    static var memoKey: String = "PreferTrivial"
    
    var priority: Int = 100
    var preferredFirstEdge: [EdgePosition] {
        get {
            return [.UB, .UF, .DB]
        }
    }
}

class AvoidMisorientedEdge : MemoPreference {
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = false
    
    static var description: String = "Avoid Misoriented Edges"
    
    static var explanation: String = "Misoriented edges are more difficult to solve, due to ugly algorithms or cube rotation. Turn on this switch so that these pieces will be chosen as cycle break after others."
    
    static var memoKey: String = "AvoidMisorientedEdge"
    
    var avoidedFirstEdge: [EdgePosition] = [.FU, .BD, .LB, .LD, .LF, .LU, .RB, .RD, .RF, .RU]
}

class PreferCornerWithShortSetUp: MemoPreference {
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer corner with short setup"
    
    static var explanation: String = "Turn on this switch break cycles at corner pieces with one move setup."
    
    static var memoKey: String = "PreferCornerWithShortSetUp"
    
    var preferredFirstCorner: [CornerPosition] = [.RDF, .BDR, .LDB, .FLU, .URF, .LUF, .DLF, .RBD, .RUB, .RFU]
}

class UseUFL: MemoPreference {
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Use \(corner(.UFL)) as a target"
    
    static var explanation: String = "\(corner(.UFL)) target can be solved in shorter moves than \(corner(.RDF)) by U2 [J-Perm] U. Turn on this switch so that one move setups to \(corner(.UFL)) is considered equivalently to that of \(corner(.RDF))."
    
    static var memoKey: String = "UseUFL"
    
    var preferredFirstCorner: [CornerPosition] = [.UFL, .RFU, .DFR, .LFD]
}

class PreferSameOuterLayerCommutator: MemoPreference {
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer same layer outer commutator groups"
    
    static var explanation: String = ""
    
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
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer same inner layer commutator"
    
    static var explanation: String = ""
    
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
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer cross layer outer commutator groups"
    
    static var explanation: String = ""
    
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
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer easy setup (no more than 1 move)"
    
    static var explanation: String = ""
    
    static var memoKey: String = "Prefer1MoveSetUp"
    var preferredFirstEdge: [EdgePosition] = [.UB, .UL, .UR, .UF, .RB, .LB, .DB]
}
