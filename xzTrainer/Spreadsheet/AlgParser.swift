//
//  AlgParser.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/3/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

func locateSpecialCharacters(fromAlg alg: String) throws -> (colonIndex: Int?, commaIndex: Int?) {
    var level = 0
    var colonLv0Index: Int? = nil
    var colonExists = false
    var commasLv1Index: Int? = nil
    for i in 0 ..< alg.count {
        switch alg[i] {
        case "[": level += 1
        case "]": level -= 1
        case ",":
            if (level == 0) {
                throw XZError.error(msg: "Unexpected comma (,) found in this part of the algorithm: \(alg)")
            }
            if level != 1 {
                break;
            }
            if commasLv1Index != nil {
                throw XZError.error(msg: "Too many commas (,) found in this part of the algorithm: \(alg)")
            }
            commasLv1Index = i
        case ":":
            colonExists = true
            if level != 0 {
                break;
            }
            if colonLv0Index != nil {
                throw XZError.error(msg: "Too many colons (:) found in this part of the algorithm: \(alg)")
            }
            colonLv0Index = i
        default: break
        }
    }
    if colonLv0Index == nil && commasLv1Index == nil && colonExists {
        throw XZError.error(msg: "Unexpected colon (:) found in this part of the algorithm: \(alg) (Maybe the setup moves were not separated by (:) or were also wrapped in [])")
    }
    return (colonIndex: colonLv0Index, commaIndex: commasLv1Index)
}

func parse(alg: String) throws -> Algorithm {
    let alg = alg.trimmingCharacters(in: .whitespaces)
    let colonLv0Index: Int?
    let commasLv1Index: Int?
    do {
        (colonLv0Index, commasLv1Index) = try locateSpecialCharacters(fromAlg: alg)
    } catch let error {
        throw error
    }
    
    if colonLv0Index == nil && commasLv1Index == nil {
        let result = MoveSequence(fromString: alg)
        if result == nil {
            throw XZError.error(msg: "I can't understand this algorithm: \(alg)")
        }
        return result!
    }
    if colonLv0Index != nil {
        do {
            let aPart = try parse(alg: String(alg[0 ..< colonLv0Index!]))
            let bPart = try parse(alg: String(alg[colonLv0Index! + 1 ..< alg.count]))
            return Conjugate(A: aPart, B: bPart)
        } catch let error {
            throw error
        }
    }
    if commasLv1Index! + 1 >= alg.count {
        throw XZError.error(msg: "Expecting more expressions after comma (,): \(alg)")
    }
    do {
        let aPart = try parse(alg: String(alg[1 ..< commasLv1Index!]))
        let bPart = try parse(alg: String(alg[commasLv1Index! + 1 ..< alg.count - 1]))
        return Commutator(A: aPart, B: bPart)
    } catch let error {
        throw error
    }
}
