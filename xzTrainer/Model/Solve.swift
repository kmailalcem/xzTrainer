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
    var timeIncludingPenalty: Double {
        let result = time + penalty
        if result < 0 {
            return Double.infinity
        }
        return result
    }
    
    public static func < (lhs: Solve, rhs: Solve) -> Bool {
        return lhs.timeIncludingPenalty < rhs.timeIncludingPenalty
    }
    
    public static func == (lhs: Solve, rhs: Solve) -> Bool {
        return lhs.timeIncludingPenalty == rhs.timeIncludingPenalty
    }
}

public func convertTimeDoubleToString(_ target: Double) -> String {
    if target < 0 {
        return "N/A"
    } else if target == Double.infinity {
        return "DNF"
    } else {
        return String(format: "%.3f", target)
    }
}

extension Array where Element == Solve {
    func mo(_ n: Int, ending end: Int) -> Double {
        if (end - n < 0) {
            return -1
        }
        
        let temp = self[(end - n) ..< end]
        
        return self[(end - n) ..< end].reduce(0, { partialResult, element in
            return partialResult + element.timeIncludingPenalty
        }) / Double(temp.count)
    }
    
    func mo(_ n: Int) -> Double! {
        return mo(n, ending: count)
    }
    
    func ao(_ n: Int, ending end: Int) -> Double {
        if n < 3 || (end - n < 0) {
            return -1
        }
        let temp = self[(end - n) ..< end]
        
        var minIndex = end - n
        var maxIndex = end - n
        var minimum = temp[minIndex]
        var maximum = temp[maxIndex]
        
        for i in (end - n) ..< end {
            if temp[i] < minimum {
                minimum = temp[i]
                minIndex = i
            } else if temp[i] > maximum {
                maximum = temp[i]
                maxIndex = i
            }
        }
        
        var sum: Double = 0
        
        for i in (end - n) ..< end {
            if i != minIndex && i != maxIndex {
                sum += temp[i].timeIncludingPenalty
            }
        }
        
        return sum / Double(n - 2)
    }
    
    func ao(_ n: Int) -> Double! {
        return ao(n, ending: count)
    }
}

