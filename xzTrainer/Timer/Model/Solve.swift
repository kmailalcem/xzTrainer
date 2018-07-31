//
//  SolveStats.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

extension Solve: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = Solve()
        copy.best = self.best
        copy.mo3 =  self.mo3
        copy.ao5 = self.ao5
        copy.ao12 = self.ao12
        copy.ao100 = self.ao100
        copy.ao1000 = self.ao1000
        copy.scramble = self.scramble
        copy.date = self.date
        copy.cornerMemo = self.cornerMemo
        copy.cornerTwists = self.cornerTwists
        copy.edgeMemo = self.edgeMemo
        copy.edgeFlips = self.edgeFlips
        copy.penalty = self.penalty
        copy.time = self.time
        return copy
    }
    
    public func copyFrom(copy: Solve) {
        self.best = copy.best
        self.mo3 = copy.mo3
        self.ao5 = copy.ao5
        self.ao12 = copy.ao12
        self.ao100 = copy.ao100
        self.ao1000 = copy.ao1000
        self.scramble = copy.scramble
        self.date = copy.date
        self.cornerMemo = copy.cornerMemo
        self.cornerTwists = copy.cornerTwists
        self.edgeMemo = copy.edgeMemo
        self.edgeFlips = copy.edgeFlips
        self.penalty = copy.penalty
        self.time = copy.time
    }
}

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
        let minute = Int(target / 60)
        let second = Double(Int(target) % 60) + target - Double(Int(target))
        let minutePart = minute == 0 ? "" : "\(minute):"
        var secondPart: String {
            if second < 10 && minute != 0{
                return String(format: "0%.3f", second)
            }
            return String(format: "%.3f", second)
        }
        
        return minutePart + secondPart
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

