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
    
    case m2Edges = "m2 edges"
    case opCorners = "old pochmann corners"
    case advancedM2 = "advanced m2"
    
    case preferTrivialTitle = "prefer trivial title"
    case preferTrivialDescription = "prefer trivial description"
    
    case avoidMisorientedEdgesTitle = "avoid misoriented edge title"
    case avoidMisorientedEdgesDescription = "avoid misoriented edge description"
    
    case preferCornerWithShortSetUpTitle = "prefer corner with short setup title"
    case preferCornerWithShortSetUpDescription = "prefer corner with short setup description"
    
    case useUFLTitle = "use UFL title"
    case useUFLDescription = "use UFL description"
    
    case preferSameOuterLayerCommutatorTitle = "prefer same outer layer commutator title"
    case preferSameOuterLayerCommutatorDescription = "prefer same outer layer commutator description"

    case preferSameInnerLayerCommutatorTitle = "prefer same inner layer commutator title"
    case preferSameInnerLayerCommutatorDescription = "prefer same inner layer commutator description"
    
    case preferCrossOuterLayerCommutatorTitle = "prefer cross outer layer commutator title"
    case preferCrossOuterLayerCommutatorDescription = "prefer cross outer layer commutator description"
    
    case prefer1MoveSetupTitle = "prefer 1 move setup title"
    case prefer1MoveSetupDescription = "prefer 1 move setup description"
}
