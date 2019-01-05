//
//  random.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/2/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

/// represents a commutator of the form [A, B] (A B A' B').
/// This class represents an Individual in Composite pattern.
class Commutator: Algorithm {
    var inversed: Algorithm {
        return Commutator(inverseOf: self)
    }
    
    /// initializer from two move sequences
    init(A: Algorithm, B: Algorithm) {
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
    var expanded : Algorithm {
        var temp = A.expanded as! MoveSequence
        temp.append(B.expanded as! MoveSequence)
        temp.append(A.inversed.expanded as! MoveSequence)
        temp.append(B.inversed.expanded as! MoveSequence)
        return temp;
    }
    var A : Algorithm
    var B : Algorithm
}
