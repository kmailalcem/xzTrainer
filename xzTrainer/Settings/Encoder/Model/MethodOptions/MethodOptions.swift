//
//  UseShortSetUp.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

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
    
    var defaultPriority: Int = 100
    
    var preferredFirstEdge: [EdgePosition] {
        get {
            return [.UB, .UF, .DB]
        }
    }
}


class AvoidMisorientedEdge : MemoPreference {
    var defaultPriority: Int = 0
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = false
    
    static var description: String = "Avoid Misoriented Edges"
    
    static var explanation: String = "Misoriented edges are more difficult to solve, due to ugly algorithms or cube rotation. Turn on this switch so that these pieces will be chosen as cycle break after others."
    
    static var memoKey: String = "AvoidMisorientedEdge"
    
    var avoidedFirstEdge: [EdgePosition] = [.FU, .BD, .LB, .LD, .LF, .LU, .RB, .RD, .RF, .RU]
}

class PreferCornerWithShortSetUp: MemoPreference {
    var defaultPriority: Int = 0
    
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer corner with short setup"
    
    static var explanation: String = "Turn on this switch break cycles at corner pieces with one move setup."
    
    static var memoKey: String = "PreferCornerWithShortSetUp"
    
    var preferredFirstCorner: [CornerPosition] = [.RDF, .BDR, .LDB, .FLU, .URF, .LUF, .DLF, .RBD, .RUB, .RFU]
}

class UseUFL: MemoPreference {
    var defaultPriority: Int = 0
    
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Use \(corner(.UFL)) as a target"
    
    static var explanation: String = "\(corner(.UFL)) target can be solved in shorter moves than \(corner(.RDF)) by U2 [J-Perm] U. Turn on this switch so that one move setups to \(corner(.UFL)) is considered equivalently to that of \(corner(.RDF))."
    
    static var memoKey: String = "UseUFL"
    
    var preferredFirstCorner: [CornerPosition] = [.UFL, .RFU, .DFR, .LFD]
}

class PreferSameOuterLayerCommutator: MemoPreference {
    var defaultPriority: Int = 0
    
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
    var defaultPriority: Int = 0
    
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
    var defaultPriority: Int = 0
    
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
    var defaultPriority: Int = 0
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = "Prefer easy setup (no more than 1 move)"
    
    static var explanation: String = ""
    
    static var memoKey: String = "Prefer1MoveSetUp"
    var preferredFirstEdge: [EdgePosition] = [.UB, .UL, .UR, .UF, .RB, .LB, .DB]
}

