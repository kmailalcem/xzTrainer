//
//  LocalizationMemo.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/16/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

enum LocalizableMemo: String, Localizable {
    
    var tableName: String {
        return "Memo"
    }
    
    case requiresBuffer = "requires buffer"
    case m2Edges = "m2 edges"
    case opCorners = "old pochmann corners"
    case opEdges = "old pochmann edges"
    case advancedM2 = "advanced m2"
    case threeStyle = "3-style"
    
    case preferTrivialTitle = "prefer trivial title"
    case preferTrivialDescription = "prefer trivial description"
    
    case avoidMisorientedEdgesTitle = "avoid misoriented edge title"
    case avoidMisorientedEdgesDescription = "avoid misoriented edge description"
    
    case preferCornerWithShortSetUpTitle = "prefer corner with short setup title"
    case preferCornerWithShortSetUpDescription = "prefer corner with short setup description"
    
    case preferEdgesWithShortSetUpTitle = "prefer edges with short setup title"
    case preferEdgesWithShortSetUpDescription = "prefer edges with short setup description"
    
    case useUFLTitle = "use UFL title"
    case useUFLDescription = "use UFL description"
    
    case useUFTitle = "use UF title"
    case useUFDescription = "use UF description"
    
    case useUBTitle = "use UB title"
    case useUBDescription = "use UB description"
    
    case preferSameOuterLayerCommutatorTitle = "prefer same outer layer commutator title"
    case preferSameOuterLayerCommutatorDescription = "prefer same outer layer commutator description"

    case preferSameInnerLayerCommutatorTitle = "prefer same inner layer commutator title"
    case preferSameInnerLayerCommutatorDescription = "prefer same inner layer commutator description"
    
    case preferCrossOuterLayerCommutatorTitle = "prefer cross outer layer commutator title"
    case preferCrossOuterLayerCommutatorDescription = "prefer cross outer layer commutator description"
    
    case prefer1MoveSetupTitle = "prefer 1 move setup title"
    case prefer1MoveSetupDescription = "prefer 1 move setup description"
    
    case preferInterchangeableCornersTitle = "prefer interchangeable corners title"
    case preferInterchangeableCornersDescription = "prefer interchangeable corners description"
    
    case preferInterchangeableEdgesTitle = "prefer interchangeable edges title"
    case preferInterchangeableEdgesDescription = "prefer interchangeable edges description"
    
    case preferPureCommutatorTitle = "prefer pure commutator title"
    case preferPureCommutatorDescription = "prefer pure commutator description"
    
    case avoidBadInsersionTitle = "avoid bad insertion title"
    case avoidBadInsersionDescription = "avoid bad insertion description"
    
    case avoidTwistAlgTitle = "avoid twist algs title"
    case avoidTwistAlgDescription = "avoid twist algs descrtiption"
}
