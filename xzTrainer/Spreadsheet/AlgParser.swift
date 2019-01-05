//
//  AlgParser.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/3/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

func parse(alg: String) -> Algorithm? {
    let alg = alg.trimmingCharacters(in: .whitespaces)
    print("parsing \(alg)")
    var level = 0
    var colonLv0Index: Int? = nil
    var colonExists = false
    var commasLv1Index: Int? = nil
    for i in 0 ..< alg.count {
        switch alg[i] {
        case "[":
            level += 1
        case "]":
            level -= 1
        case ",":
            if level != 1 {
                break;
            }
            if commasLv1Index != nil {
                return nil
            }
            commasLv1Index = i
        case ":":
            colonExists = true
            if level != 0 {
                break;
            }
            if colonLv0Index != nil {
                return nil;
            }
            colonLv0Index = i
        default: break
        }
    }
    if colonLv0Index == nil && commasLv1Index == nil {
        return colonExists ? nil : MoveSequence(fromString: alg)
    }
    if colonLv0Index != nil {
        let aPart = parse(alg: String(alg[0 ..< colonLv0Index!]))
        let bPart = parse(alg: String(alg[colonLv0Index! + 1 ..< alg.count]))
        if aPart == nil || bPart == nil {
            return nil
        }
        return Conjugate(A: aPart!, B: bPart!)
    }
    if commasLv1Index != nil {
        let aPart = parse(alg: String(alg[1 ..< commasLv1Index!]))
        let bPart = parse(alg: String(alg[commasLv1Index! + 1 ..< alg.count - 1]))
        if aPart == nil || bPart == nil {
            return nil
        }
        return Commutator(A: aPart!, B: bPart!)
    }
    
    return nil
}
