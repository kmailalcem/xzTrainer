//
//  SolveStats.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

struct SolveTime {
    var time: Double = 0
    var scramble: String = ""
    
    init(time: Double, scramble: String) {
        self.time = time
        self.scramble = scramble
    }
}

extension SolveTime: Comparable {
    static func < (lhs: SolveTime, rhs: SolveTime) -> Bool {
        return lhs.time < rhs.time
    }
    
    static func == (lhs: SolveTime, rhs: SolveTime) -> Bool {
        return lhs.time == rhs.time
    }
}

extension Array where Element == SolveTime {
    func mo(_ n: Int, ending end: Int) -> Double! {
        if (end - n < 0) {
            return nil
        }
        return reduce(0, { partialResult, element in
            return partialResult + element.time
        }) / Double(count)
    }
    
    func mo(_ n: Int) -> Double! {
        return ao(n, ending: count)
    }
    
    func ao(_ n: Int, ending end: Int) -> Double! {
        if n < 3 || (end - n < 0) {
            return nil
        }
        
        let mininum = self.min()!.time
        
        let maximum = self.max()!.time
        
        return (reduce(0, { partialResult, element in
            return partialResult + element.time
        }) - mininum - maximum) / Double(count - 2)
    }
    
    func ao(_ n: Int) -> Double! {
        return mo(n, ending: count)
    }
}

