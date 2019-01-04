//
//  random.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/2/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

/// represents a commutator of the form [A, B] (A B A' B')
class Commutator {
    /// initializer from two move sequences
    init(A: MoveSequence, B: MoveSequence) {
        self.A = A
        self.B = B
    }
    
    /// inverse of commutator
    init(inverseOf commutator: Commutator) {
        A = commutator.B
        B = commutator.A
    }
    
    /// parse string
    init?(fromString alg: String) {
        var parts = alg.split { (c) -> Bool in
            return c == "[" || c == "," || c == "]"
        }
        if parts.count != 2 {
            return nil
        }
        let Aopt = MoveSequence(fromString: String(parts[0]))
        let Bopt = MoveSequence(fromString: String(parts[1]))
        if Aopt == nil || Bopt == nil {
            return nil
        }
        A = Aopt!
        B = Bopt!
    }
    
    /// string representation of commutator
    var string : String {
        return "[ \(A.string), \(B.string)]"
    }
    
    /// expand commutator
    var expanded : MoveSequence {
        var temp = A
        temp.append(B)
        temp.append(MoveSequence(inverseOf: A))
        temp.append(MoveSequence(inverseOf: B))
        return temp;
    }
    var A : MoveSequence
    var B : MoveSequence
}
