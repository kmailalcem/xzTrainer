//
//  random.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/2/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

class Commutator {
    init(A: [Turn], B: [Turn]) {
        self.A = A
        self.B = B
    }
    var A : [Turn]
    var B : [Turn]
}

fileprivate func inverse(of turns: [Turn]) -> [Turn] {
    return []
}
