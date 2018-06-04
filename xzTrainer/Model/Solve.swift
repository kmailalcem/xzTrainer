//
//  SolveStats.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation
/*
struct Solve {
    var time: Double = 0
    var scramble: String = ""
    
    init(time: Double, scramble: String) {
        self.time = time
        self.scramble = scramble
    }
}
*/

extension Solve: Comparable {
    public static func < (lhs: Solve, rhs: Solve) -> Bool {
        return lhs.time < rhs.time
    }
    
    public static func == (lhs: Solve, rhs: Solve) -> Bool {
        return lhs.time == rhs.time
    }
}

public func convertTimeDoubleToString(_ target: Double) -> String {
    if target == -1 {
        return "N/A"
    } else {
        return String(format: "%.3f", target)
    }
}

extension Array where Element == Solve {
    func mo(_ n: Int, ending end: Int) -> Double {
        if (end - n < 0) {
            return -1
        }
        return reduce(0, { partialResult, element in
            return partialResult + element.time
        }) / Double(count)
    }
    
    func mo(_ n: Int) -> Double! {
        return ao(n, ending: count)
    }
    
    func ao(_ n: Int, ending end: Int) -> Double {
        if n < 3 || (end - n < 0) {
            return -1
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

