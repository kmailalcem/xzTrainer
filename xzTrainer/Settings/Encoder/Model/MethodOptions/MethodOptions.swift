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
    Prefer1MoveSetUp(),
    PreferInterchangeableCorners(),
    PreferInterchangeableEdges(),
    OPPreferShortSetup(),
    UseUB(),
    UseUF()
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

class OPPreferShortSetup: MemoPreference {
    var defaultPriority: Int = 80
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    static var description: String = LocalizableMemo.prefer1MoveSetupTitle.localized
    
    static var explanation: String = LocalizableMemo.prefer1MoveSetupDescription.localized(edge(.UL), edge(.FL), edge(.DL), edge(.BL))
    
    static var memoKey: String = "OPPreferShortSetup"
    var preferredFirstEdge: [EdgePosition] = [.UL, .FL, .DL, .BL]
}

class UseUF: MemoPreference {
    static var memoKey: String = "UseUF"
    
    static var description: String = LocalizableMemo.useUFTitle.localized(edge(.UF))
    
    static var explanation: String = LocalizableMemo.useUFDescription.localized(edge(.UF))
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    var defaultPriority: Int = 30
    
    var preferredFirstEdge: [EdgePosition] = [.UF, .BU, .DB, .FD]
}

class UseUB: MemoPreference {
    static var memoKey: String = "UseUB"
    
    static var description: String = LocalizableMemo.useUBTitle.localized(edge(.UB));
    
    static var explanation: String = LocalizableMemo.useUFDescription.localized(edge(.UB))
    
    var isEdgeMethod: Bool = true
    
    var isPreferringMethod: Bool = true
    
    var defaultPriority: Int = 25
    
    var preferredFirstEdge: [EdgePosition] = [.UB, .BD, .DF, .FU]
}

class PreferInterchangeableCorners: MemoPreference {
    static var memoKey: String = "PreferInterchangeableCorners"
    
    static var description: String = LocalizableMemo.preferInterchangeableCornersTitle.localized
    
    static var explanation: String = LocalizableMemo.preferInterchangeableCornersDescription.localized

    var isPreferringMethod: Bool = true
    
    var defaultPriority: Int = 100
    
    var isEdgeMethod: Bool = false
    
    var preferredFirstCorner: [CornerPosition] {
        var result = [CornerPosition]()
        for corner in CornerSticker.allValues {
            if (areInerchangeable(UserSetting.shared.general.cornerBuffer, corner)) {
                result.append(corner)
            }
        }
        return result
    }
    
    func preferredSecondCorner(for first: CornerPosition) -> [CornerPosition] {
        var result = [CornerPosition]()
        for corner in CornerSticker.allValues {
            if (areInerchangeable(first, corner)) {
                result.append(corner)
            }
        }
        return result
    }
}

class PreferInterchangeableEdges: MemoPreference {
    static var memoKey: String = "PreferInterchangeableEdges"
    
    static var description: String = LocalizableMemo.preferInterchangeableEdgesTitle.localized
    
    static var explanation: String = LocalizableMemo.preferInterchangeableEdgesDescription.localized
    
    var isPreferringMethod: Bool = true
    
    var defaultPriority: Int = 100
    
    var isEdgeMethod: Bool = true
    
    var preferredFirstEdge: [EdgePosition] {
        var result = [EdgePosition]()
        for edge in EdgePosition.allValues {
            if (areInerchangeable(UserSetting.shared.general.edgeBuffer, edge)) {
                result.append(edge)
            }
        }
        return result
    }
    
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        var result = [EdgePosition]()
        for edge in EdgePosition.allValues {
            if (areInerchangeable(first, edge)) {
                result.append(edge)
            }
        }
        return result
    }
}

class URFOrozcoCornerPreferPureCommutator: MemoPreference {
    static var memoKey: String = "URFOrozcoCornerPreferPureCommutator"
    
    static var description: String = LocalizableMemo.preferPureCommutatorTitle.localized
    
    static var explanation: String = LocalizableMemo.preferPureCommutatorDescription.localized
    
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = true
    
    var defaultPriority: Int = 100
    
    var preferredFirstCorner: [CornerPosition] = [.UBR, .DLF, .LFD, .FDL, .BLD, .LDB, .RBD, .RDF]
    
}

class URFOrozcoCornerAvoidBadInsertion: MemoPreference {
    static var memoKey: String = "URFOrozcoCornerAvoidBadInsertion"
    
    static var description: String = LocalizableMemo.avoidBadInsersionTitle.localized
    
    static var explanation: String = LocalizableMemo.avoidBadInsersionDescription.localized
    
    var isEdgeMethod: Bool = false;
    
    var isPreferringMethod: Bool = false;
    
    var defaultPriority: Int = 100
    
    var avoidedFirstCorner: [CornerPosition] = [.DFR, .DRB]
}

class URFOrozcoAvoidTwistAlg: MemoPreference {
    static var memoKey: String = "URFOrozcoAvoidTwistAlg"
    
    static var description: String = LocalizableMemo.avoidTwistAlgTitle.localized
    
    static var explanation: String = LocalizableMemo.avoidTwistAlgDescription.localized(corner(.BRU), corner(.RUB))
    
    var isEdgeMethod: Bool = false
    
    var isPreferringMethod: Bool = false
    
    var defaultPriority: Int = 90
    
    var avoidedFirstCorner: [CornerPosition] = [.BRU, .RUB]
}
