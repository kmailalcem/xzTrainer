//
//  Conjugate.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/3/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

/// represents a conjugate of the form A : B (A B A')
class Conjugate {
    /// initializer from two move sequences
    init(A: MoveSequence, B: MoveSequence) {
        self.A = A
        self.B = B
    }
    
    /// inverse of conjugate
    init(inverseOf other: Conjugate) {
        A = other.A
        B = MoveSequence(inverseOf: other.B)
    }
    
    /// parse string
    init?(fromString alg: String) {
        var parts = alg.split(separator: ":")
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
    
    /// string representation of conjugates
    var string : String {
        return "\(A.string): \(B.string)"
    }
    
    /// linear expansion
    var expanded : MoveSequence {
        var temp = A
        temp.append(B)
        temp.append(MoveSequence(inverseOf: A))
        return temp
    }
    
    private var A : MoveSequence
    private var B : MoveSequence
}
