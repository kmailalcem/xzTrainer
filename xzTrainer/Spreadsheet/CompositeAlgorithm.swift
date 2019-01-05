//
//  CompositeAlgorithm.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/5/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

/// Composite Algorithm is a class that has a container of generic algorithms.
/// This class corresponds to a Composite in Composite design pattern.
class CompositeAlgorithm : Algorithm {
    init(components: [Algorithm]) {
        self.components = components
    }
    
    var expanded: Algorithm {
        return components.reduce(MoveSequence(), { (result: MoveSequence, alg: Algorithm) -> MoveSequence in
            var result = result
            result.append(alg.expanded as! MoveSequence)
            return result
        })
    }
    
    var inversed: Algorithm {
        var reversed = [Algorithm](components.reversed())
        for i in 0 ..< reversed.count {
            reversed[i] = reversed[i].inversed
        }
        return CompositeAlgorithm(components: reversed)
    }
    
    var string: String {
        return components.reduce("", { (result: String, alg: Algorithm) -> String in
            return result + alg.string
        })
    }
    
    private var components: [Algorithm] = []
}
