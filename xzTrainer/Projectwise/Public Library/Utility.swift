//
//  PublicEnums.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/5/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

/// returns the inverse of the supplied move
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

/// Absolute position on the cube. This avoids the confusion of, for example, whether the UF piece refer to the piece currently in the UF position or the white green piece in a nonscrambled, normally oriented cube
public typealias CornerPosition = CornerSticker
public typealias EdgePosition = EdgeSticker

/**  # Returns the string representation of the array of edge pieces in the following format:
     - showInLetter: A, B, C
     - not Show In Letter: UF, FU, UL
 */
func formatedPieces(_ pieces: [EdgeSticker], showInLetters: Bool) -> String {
    var result = ""
    var separated = false
    for piece in pieces {
        let letter = UserSetting.shared.general.letterScheme[piece]
        // do not show anything if user didn't label
        if letter.count == 0 {
            continue
        }
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
    return result
}
    
/**
     # Returns the string representation of the array of corner pieces in the following format:
     - showInLetter: A, B, C
     - not Show In Letter: UFL, FLU, LUF
 */
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

/// returns if the given pieces are interchangeable
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

/// returns if the key exists in userDefaults
func keyExists(_ key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

/// returns the stored value of the given key if this key exists. Otherwise returns the default value.
func storedValue<T>(forKey key: String, defaultValue: T) -> T {
    let value = UserDefaults.standard.value(forKey: key) as? T
    return value == nil ? defaultValue : value!
}

/// returns a ThemeAlertController with confirmation
func makeConfirm(title: String = LocalizationGeneral.areYouSure.localized , message: String, handler: @escaping (UIAlertAction) -> Void) -> ThemeAlertController {
    let alert = ThemeAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: LocalizationGeneral.yes.localized, style: .default, handler: handler))
    alert.addAction(UIAlertAction(title: LocalizationGeneral.cancel.localized, style: .cancel, handler: nil))
    return alert
}

/// returns the alert action with cancel
func cancelAction() -> UIAlertAction {
    return UIAlertAction(title: LocalizationGeneral.cancel.localized, style: .cancel, handler: nil)
}
