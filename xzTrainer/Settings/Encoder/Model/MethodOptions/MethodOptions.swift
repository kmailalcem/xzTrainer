//
//  UseShortSetUp.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 8/1/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

fileprivate func edge(_ piece: EdgeSticker) -> String {
    if UserSetting.shared.general.letterScheme[piece].count == 0 {
        return piece.string
    }
    return piece.string + "/\(UserSetting.shared.general.letterScheme[piece])"
}

fileprivate func corner(_ piece: CornerSticker) -> String {
    if UserSetting.shared.general.letterScheme[piece].count == 0 {
        return piece.string
    }
    return piece.string + "/\(UserSetting.shared.general.letterScheme[piece])"
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
    
    static var description: String = LocalizableMemo.preferTrivialTitle.localized + " (\(edge(.UB)), \(edge(.UF)), \(edge(.DB)))"
    
    static var explanation: String = LocalizableMemo.preferTrivialDescription.localized(edge(.UB), edge(.UF), edge(.DB))
    
    static var memoKey: String = "PreferTrivial"
    
    var defaultPriority: Int = 100
    
    var preferredFirstEdge: [EdgePosition] {
        get {
            return [.UB, .UF, .DB]
        }
    }
}


class AvoidMisorientedEdge : MemoPreference {
    var defaultPriority: Int = 50
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = false
    
    static var description: String = LocalizableMemo.avoidMisorientedEdgesTitle.localized
    
    static var explanation: String = LocalizableMemo.avoidMisorientedEdgesDescription.localized
    
    static var memoKey: String = "AvoidMisorientedEdge"
    
    var avoidedFirstEdge: [EdgePosition] = [.FU, .BD, .LB, .LD, .LF, .LU, .RB, .RD, .RF, .RU]
}

class PreferCornerWithShortSetUp: MemoPreference {
    var defaultPriority: Int = 100
    
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.preferCornerWithShortSetUpTitle.localized
    
    static var explanation: String = LocalizableMemo.preferCornerWithShortSetUpDescription.localized
    
    static var memoKey: String = "PreferCornerWithShortSetUp"
    
    var preferredFirstCorner: [CornerPosition] = [.RDF, .BDR, .LDB, .FLU, .URF, .LUF, .DLF, .RBD, .RUB, .RFU]
}

class UseUFL: MemoPreference {
    var defaultPriority: Int = 30
    
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.useUFLTitle.localized(corner(.UFL))
    
    static var explanation: String = LocalizableMemo.useUFLDescription.localized(corner(.UFL), corner(.RDF), corner(.UFL), corner(.RDF))
    
    static var memoKey: String = "UseUFL"
    
    var preferredFirstCorner: [CornerPosition] = [.UFL, .RFU, .DFR, .LFD]
}

class PreferSameOuterLayerCommutator: MemoPreference {
    var defaultPriority: Int = 70
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.preferSameOuterLayerCommutatorTitle.localized
    
    static var explanation: String = LocalizableMemo.preferSameOuterLayerCommutatorDescription.localized(edge(.DF), edge(.UR), edge(.UR), edge(.UR), edge(.UR), edge(.UR))
    
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
    var defaultPriority: Int = 70
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.preferSameInnerLayerCommutatorTitle.localized
    
    static var explanation: String = LocalizableMemo.preferSameInnerLayerCommutatorDescription.localized(edge(.DF), edge(.RU), edge(.RU), edge(.RU), edge(.RU), edge(.RU))
    
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
    var defaultPriority: Int = 90
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.preferCrossOuterLayerCommutatorTitle.localized
    
    static var explanation: String = LocalizableMemo.preferCrossOuterLayerCommutatorDescription.localized(edge(.UL), edge(.UR), edge(.UL), edge(.UR))
    
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
    var defaultPriority: Int = 80
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.prefer1MoveSetupTitle.localized
    
    static var explanation: String = LocalizableMemo.prefer1MoveSetupDescription.localized(edge(.DB), edge(.UL), edge(.RB), edge(.UB))
    
    static var memoKey: String = "Prefer1MoveSetUp"
    var preferredFirstEdge: [EdgePosition] = [.UB, .UL, .UR, .UF, .RB, .LB, .DB]
}

