//
//  Scramble.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/21/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class Scrambler {
   
    private enum Occupancy {
        case EMPTY, LEFT, RIGHT, FULL
    }
    
    private enum Input: Int {
        case LEFT, RIGHT
    }
    
    private static let faceTurnNotations
        = [["L", "R"], ["F", "B"], ["U", "D"]]
    
    private static var occupancyStatusSoFar : [Occupancy]
        = [.EMPTY, .EMPTY, .EMPTY]
    
    public static func getRandomScrambleWithLength(from minScrambleLength: Int,
                                      to maxScrambleLength: Int,
                                      withOrientationMangle: Bool) -> String {
        
        let scrambleLength = randomIntInRange(
            start: minScrambleLength, end: maxScrambleLength)
        let movesWithoutDirections = getRandomMovesWithoutDirections(
            ofLength: scrambleLength, withOrientationMangle: withOrientationMangle)
        var resultScramble = ""
        for move in movesWithoutDirections {
            resultScramble.append(assignRandomDirection(toMove: move))
        }
        return resultScramble
    }
    
    private static func getRandomMovesWithoutDirections(ofLength scrambleLength: Int,
                                                        withOrientationMangle: Bool) -> [String] {
        var movesWithoutDirections: [String] = []
        
        let mangleSize = withOrientationMangle ? 0 : randomIntInRange(start: 1, end: 3)
        for i in 0 ..< scrambleLength {
            movesWithoutDirections.append(getRandomMoveWithoutConflict(withOrientationMangle: i >= scrambleLength - mangleSize))
        }
        
        return movesWithoutDirections
    }
    
    private static func getRandomMoveWithoutConflict(withOrientationMangle: Bool) -> String {
        let (faceClass, faceWithinClass) = obtainMoveWithoutRepetition()
        updateOccupancyStatus(takenClass: faceClass, takenFace: faceWithinClass)
        let moveBase = faceTurnNotations[faceClass][faceWithinClass.rawValue]
        if withOrientationMangle {
            return moveBase + "w"
        } else {
            return moveBase
        }
    }
    
    private static func updateOccupancyStatus(takenClass: Int,
                                              takenFace: Input) {
        switch (occupancyStatusSoFar[takenClass]) {
        case .EMPTY:
            if (takenFace == .RIGHT) {
                occupancyStatusSoFar[takenClass] = .RIGHT
            } else {
                occupancyStatusSoFar[takenClass] = .LEFT
            }
            resetAllOccupancyStatusToEmpty(except: takenClass)
            break
        case .LEFT:
            occupancyStatusSoFar[takenClass] = .FULL
            resetAllOccupancyStatusToEmpty(except: takenClass)
            break;
        case .RIGHT:
            occupancyStatusSoFar[takenClass] = .FULL
            resetAllOccupancyStatusToEmpty(except: takenClass)
            break;
        case .FULL:
            // should not happen by construction
            exit(1)
            break
        }
    }
    
    private static func obtainMoveWithoutRepetition() -> (FaceClass: Int,
        FaceWithinClass: Input) {
        var faceClass: Int
        var faceWithinClass: Input
        repeat {
            faceClass = randomIntInRange(start: 0, end: 3)
            faceWithinClass = Input(rawValue: randomIntInRange(start: 0, end: 2))!
        } while willResultInRepetition(
            status: occupancyStatusSoFar[faceClass], input: faceWithinClass)
        
        return (faceClass, faceWithinClass)
    }
    
    private static func willResultInRepetition(
        status: Occupancy, input: Input) -> Bool{
        return status == .FULL ||
            (status == .LEFT && input == .LEFT) ||
            (status == .RIGHT && input == .RIGHT)
    }
    
    private static func resetAllOccupancyStatusToEmpty(except faceClass: Int) {
        for i in 0 ..< 3 {
            if (i != faceClass) {
                occupancyStatusSoFar[i] = .EMPTY
            }
        }
    }
    
    private static func assignRandomDirection(toMove move: String) -> String {
        var move = move
        let direction = randomIntInRange(start: 0, end: 3)
        switch direction {
        case 1:
            move.append("' ")
        case 2:
            move.append("2 ")
        default:
            move.append(" ")
        }
        return move
    }

    private static func randomIntInRange (start: Int, end: Int) -> Int {
        return Int(arc4random_uniform(UInt32(end - start))) + start;
    }
}
