//
//  MoveSequence.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/3/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import Foundation

/// MoveSequence represents a sequence of moves.
struct MoveSequence {
    /// initializer from an array of movements
    init(_ sequence: [Movement] = []) {
        self.sequence = sequence
    }
    
    /// inverse of MoveSeqence
    init(inverseOf moves: MoveSequence) {
        sequence = inverse(of: moves.sequence)
    }
    
    /// initlializer from string
    init?(fromString alg: String) {
        let movesInScramble = alg.replacingOccurrences(of: "’", with:
            "'").split(separator: " ")
        for move in movesInScramble {
            let movement = parseMovement(String(move))
            if movement != nil {
                sequence.append(movement!)
            } else {
                print("Invalid move ignored: \(move)")
            }
        }
    }
    
    /// returns the string representation of the MoveSequence
    var string : String {
        return sequence.reduce("", { (result : String, move : Movement) -> String in
            return result + move.string + " "
        })
    }
    
    /// concatenate the other move sequences
    mutating func append(_ other: MoveSequence) {
        sequence.append(contentsOf: other.sequence)
    }
    private var sequence : [Movement] = []
    
}

func parseMovement(_ move: String) -> Movement? {
    if let aTurn = Turn(rawValue: move) {
        return aTurn
    } else if let aTurn = WideTurn(rawValue: move) {
        return aTurn
    } else if let aTurn = Rotation(rawValue: move) {
        return aTurn
    }
    print("Cannot cast turn \(move) as a valid move")
    return nil
}
