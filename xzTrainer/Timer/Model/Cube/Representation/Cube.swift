//
//  Cube.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/7/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

public class Cube : Equatable {
    
    public func scrambleCube(_ scramble: String) {
        let turnsInScramble = scramble.replacingOccurrences(of: "’", with:
            "'").split(separator: " ")
        for turnString in turnsInScramble {
            if let aTurn = Turn(rawValue: String(turnString)) {
                turn(aTurn)
            } else if let aTurn = WideTurn(rawValue: String(turnString)) {
                turn(aTurn)
            } else if let aTurn = Rotation(rawValue: String(turnString)) {
                rotate(aTurn)
            } else {
                print("Cannot cast turn \(turnString) as a valid move")
            }
        }
    }
    
    public func reScrambleCube(_ scramble: String) {
        permutation = VoidCube()
        currentOrientation = CentreCore(top: originalOrientation.top, front: originalOrientation.front)
        scrambleCube(scramble)
    }
    
    public func getColor<T: CubePiece>(at sticker: T) -> CubeColor {
        return getColor(for: self[sticker])
    }
    
    public func colorLeft() -> CubeColor {
        return leftSideColor(top: originalOrientation.top, front: originalOrientation.front)
    }
    
    public func colorRight() -> CubeColor {
        return rightSideColor(top: originalOrientation.top, front: originalOrientation.front)
    }
    
    public func colorTop() -> CubeColor {
        return originalOrientation.top
    }
    
    public func colorBottom() -> CubeColor {
        return oppositeColor(originalOrientation.top)
    }
    
    public func colorFront() -> CubeColor {
        return originalOrientation.front
    }
    
    public func colorBack() -> CubeColor {
        return oppositeColor(originalOrientation.front)
    }
    
    public func colorCenterLeft() -> CubeColor {
        return leftSideColor(top: currentOrientation.top, front: currentOrientation.front)
    }
    
    public func colorCenterRight() -> CubeColor {
        return rightSideColor(top: currentOrientation.top, front: currentOrientation.front)
    }
    
    public func colorCenterTop() -> CubeColor {
        return currentOrientation.top
    }
    
    public func colorCenterBottom() -> CubeColor {
        return oppositeColor(currentOrientation.top)
    }
    
    public func colorCenterFront() -> CubeColor {
        return currentOrientation.front
    }
    
    public func colorCenterBack() -> CubeColor {
        return oppositeColor(currentOrientation.front)
    }
    
    public static func == (lhs: Cube, rhs: Cube) -> Bool {
        var isSameWrtSameOrientation =
            lhs.currentOrientation == rhs.currentOrientation
        for i in 0 ..< NUM_STICKERS {
            if lhs.getColor(at: CornerPosition(rawValue: i)!)
                != rhs.getColor(at: CornerPosition(rawValue: i)!) {
                isSameWrtSameOrientation = false
            }
            
            if lhs.getColor(at: EdgePosition(rawValue: i)!)
                != rhs.getColor(at: EdgePosition(rawValue: i)!) {
                isSameWrtSameOrientation = false
            }
        }
        return isSameWrtSameOrientation
        
    }
    
    init() {
        permutation = VoidCube()
        originalOrientation = CentreCore()
        currentOrientation = CentreCore()
    }
    
    init(top: CubeColor, front: CubeColor, scramble: String) {
        originalOrientation = CentreCore(top: top, front: front)
        currentOrientation = CentreCore(top: top, front: front)
        permutation = VoidCube()
        scrambleCube(scramble)
    }
    
    public func rotate(_ rotation: Rotation) {
        switch rotation {
        case .x:
            rotateXPrime()
            fallthrough
        case .x2:
            rotateXPrime()
            fallthrough
        case .xPrime:
            rotateXPrime()
            break;
        case .y:
            rotateYPrime()
            fallthrough
        case .y2:
            rotateYPrime()
            fallthrough
        case .yPrime:
            rotateYPrime()
            break;
        case .z:
            rotateZPrime()
            fallthrough
        case .z2:
            rotateZPrime()
            fallthrough
        case .zPrime:
            rotateZPrime()
            break;
        }
    }
    
    public func turn(_ turning: Turn) {
        switch turning {
        case .MPrime:
            currentOrientation.rotateXPrime()
            fallthrough
        case .M2:
            currentOrientation.rotateXPrime()
            fallthrough
        case .M:
            currentOrientation.rotateXPrime()
            break; 
        case .S:
            currentOrientation.rotateZPrime()
            fallthrough
        case .S2:
            currentOrientation.rotateZPrime()
            fallthrough
        case .SPrime:
            currentOrientation.rotateZPrime()
            break; 
        case .E:
            currentOrientation.rotateYPrime()
            fallthrough
        case .E2:
            currentOrientation.rotateYPrime()
            fallthrough
        case .EPrime:
            currentOrientation.rotateYPrime()
            break;
        default:
            break;
        }
        permutation.turn(turning)
    }
    
    public func turn(_ turning: WideTurn) {
        // remove wide first
        var temp = turning.rawValue
        temp.remove(at: temp.index(after: temp.startIndex))
        // print(temp)
        turn(Turn(rawValue: temp)!)
        
        // deal with slices
        switch turning {
        case .Rw, .LwPrime:
            turn(.MPrime)
        case .Rw2, .Lw2:
            turn(.M2)
        case .RwPrime, .Lw:
            turn(.M)
        case .Uw, .DwPrime:
            turn(.E)
        case .Uw2, .Dw2:
            turn(.E2)
        case .UwPrime, .Dw:
            turn(.EPrime)
        case .Fw, .BwPrime:
            turn(.S)
        case .Fw2, .Bw2:
            turn(.S2)
        case .FwPrime, .Bw:
            turn(.SPrime)
        }
    }
    
    @discardableResult
    public func rotate (top: CubeColor, front: CubeColor) -> [Rotation] {
        var result = [Rotation]()
        if top == currentOrientation.front {
            rotate(.x)
            result.append(.x)
        } else if top == oppositeColor(currentOrientation.front) {
            rotate(.xPrime)
            result.append(.xPrime)
        } else if top == oppositeColor(currentOrientation.top) {
            rotate(.x2)
            result.append(.x2)
        } else if top ==
            rightSideColor(top: currentOrientation.top, front: currentOrientation.front) {
            rotate(.zPrime)
            result.append(.zPrime)
        } else if top ==
            leftSideColor(top: currentOrientation.top, front: currentOrientation.front) {
            rotate(.z)
            result.append(.z)
        }
        
        if front == oppositeColor(currentOrientation.front) {
            rotate(.y2)
            result.append(.y2)
        } else if front ==
            rightSideColor(top: currentOrientation.top, front: currentOrientation.front) {
            rotate(.y)
            result.append(.y)
        } else if
            front == leftSideColor(top: currentOrientation.top, front: currentOrientation.front) {
            rotate(.yPrime)
            result.append(.yPrime)
        }
        return result
    }
    
    // check if under the same orientation the cubes are the same
    public func solved() -> Bool {
        let cube = Cube()
        cube.rotate(top: currentOrientation.top, front: currentOrientation.front)
        return self == cube
    }
    
    subscript<T: CubePiece>(_ pos: T) -> T {
        return permutation[pos]
    }
    
    subscript(_ pos: CubePiece) -> CubePiece {
        if pos is EdgeSticker {
            return permutation[pos as! EdgeSticker]
        } else {
            return permutation[pos as! CornerSticker]
        }
    }
   
    private func rotateXPrime() {
        permutation.turn(.RPrime)
        permutation.turn(.M)
        permutation.turn(.L)
        currentOrientation.rotateXPrime()
    }
    
    private func rotateYPrime() {
        permutation.turn(.UPrime)
        permutation.turn(.EPrime)
        permutation.turn(.D)
        currentOrientation.rotateYPrime()
    }
    
    private func rotateZPrime() {
        permutation.turn(.FPrime)
        permutation.turn(.SPrime)
        permutation.turn(.B)
        currentOrientation.rotateZPrime()
    }
    
    private func getColor<T: CubePiece>(for sticker: T) -> CubeColor {
        if sticker is CornerSticker {
            switch sticker as! CornerSticker {
            case .UBR, .URF, .UFL, .ULB:
                return colorTop()
            case .RBD, .RDF, .RFU, .RUB:
                return colorRight()
            case .LBU, .LUF, .LFD, .LDB:
                return colorLeft()
            case .BDR, .BRU, .BUL, .BLD:
                return colorBack()
            case .DBL, .DLF, .DFR, .DRB:
                return colorBottom()
            case .FDL, .FLU, .FUR, .FRD:
                return colorFront()
            }
        } else {
            switch sticker as! EdgeSticker {
            case .UF, .UR, .UB, .UL:
                return colorTop()
            case .RB, .RD, .RF, .RU:
                return colorRight()
            case .LB, .LU, .LF, .LD:
                return colorLeft()
            case .BD, .BR, .BU, .BL:
                return colorBack()
            case .DB, .DL, .DF, .DR:
                return colorBottom()
            case .FD, .FL, .FU, .FR:
                return colorFront()
            }
        }
    }
    
    
    private var permutation : VoidCube
    private let originalOrientation : CentreCore
    private var currentOrientation : CentreCore
}
