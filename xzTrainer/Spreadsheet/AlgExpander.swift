//
//  AlgParser.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/3/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

func expand(alg: String) -> MoveSequence {
    let parts = alg.split(separator: ":")
    var commParts = MoveSequence([])
    if parts.count == 1 {
        return MoveSequence(fromString: alg) ?? MoveSequence([])
    }
    let commOpt = Commutator(fromString: String(parts[1]).trimmingCharacters(in: .whitespaces))
    if commOpt == nil {
        return MoveSequence([])
    }
    commParts = commOpt!.expanded
    let conjAOpt = MoveSequence(fromString: String(parts[0]))
    if conjAOpt == nil {
        return MoveSequence([])
    }
    return Conjugate(A: conjAOpt!, B: commParts).expanded
    
}
