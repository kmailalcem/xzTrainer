//
//  PublicEnums.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/5/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit


public func inverse(of turn: Turn) -> Turn {
    let rawValue = turn.rawValue
    if rawValue.count == 1 {
        return Turn(rawValue: rawValue + "'")!
    } else {
        if turn.rawValue.last == "2" {
            return turn
        } else {
            return Turn(rawValue: String(rawValue[...rawValue.startIndex]))!
        }
    }
}

// absolute position on the cube
// this avoids the confusion of, for example, whether the
// UF piece refer to the piece currently in the UF position
// or the white green piece in a nonscrambled, normally oriented cube
public typealias CornerPosition = CornerSticker
public typealias EdgePosition = EdgeSticker

func formatedPieces(_ pieces: [EdgeSticker], showInLetters: Bool) -> String {
    var result = ""
    var separated = false
    for piece in pieces {
        let letter = UserSetting.shared.general.letterScheme[piece]
        // do not show anything if user didn't label
        if letter.count > 0 {
            if separated {
                result += ", "
            }
            separated = true
            if showInLetters {
                result += letter
            } else {
                result += piece.string
            }
        }
    }
    return result
}

func formatedPieces(_ pieces: [CornerSticker], showInLetters: Bool) -> String {
    var result = ""
    var separated = false
    for piece in pieces {
        let letter = UserSetting.shared.general.letterScheme[piece]
        // do not show anything if user didn't label
        if letter.count > 0 {
            if separated {
                result += ", "
            }
            separated = true
            if showInLetters {
                result += letter
            } else {
                result += piece.string
            }
        }
    }
    return result
}

func areInerchangeable<T: CubePiece>(_ piece1: T, _ piece2: T) -> Bool {
    for turn in Turn.allValues {
        let cube = Cube()
        cube.turn(turn)
        if (cube[piece1] as! T).rawValue == piece2.rawValue || (cube[piece2] as! T).rawValue == piece1.rawValue {
            return true
        }
    }
    return false
}
