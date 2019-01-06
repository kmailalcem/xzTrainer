//
//  Algorithm.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/5/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

/// Algorithm protocol is an interface to all algorithm types, which includes plain sequence of moves, conjugates, and commutators.
/// This protocol corresponds to Component in Composite design pattern.
protocol Algorithm: StringRepresentable {
    /// returns the expansion into a MoveSequence.
    /// The type of return value as a MoveSequence is enforced,so can be safely forced downcast to a MoveSequence.
    var expanded: Algorithm { get }
    
    /// Returns the inverse
    var inversed: Algorithm { get }
}
