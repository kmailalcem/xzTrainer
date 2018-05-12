//
//  Cube.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/7/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

public class Cube : Equatable {
    
    private func getColor(for sticker: CornerSticker) -> CubeColor {
        switch sticker {
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
    }
    
    private func getColor(for sticker: EdgeSticker) -> CubeColor {
        switch sticker {
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
    
    public func getColor(at sticker: CornerSticker) -> CubeColor {
        return getColor(for: at(sticker))
    }
    
    public func getColor(at sticker: EdgeSticker) -> CubeColor {
        return getColor(for: at(sticker))
    }
    
    public func colorLeft() -> CubeColor {
        return leftSideColor(top: orientation.top, front: orientation.front)
    }
    
    public func colorRight() -> CubeColor {
        return rightSideColor(top: orientation.top, front: orientation.front)
    }
    
    public func colorTop() -> CubeColor {
        return orientation.top
    }
    
    public func colorBottom() -> CubeColor {
        return oppositeColor(orientation.top)
    }
    
    public func colorFront() -> CubeColor {
        return orientation.front
    }
    
    public func colorBack() -> CubeColor {
        return oppositeColor(orientation.front)
    }
    
    public static func == (lhs: Cube, rhs: Cube) -> Bool {
        return lhs.permutation == rhs.permutation &&
            lhs.orientation == rhs.orientation
    }
    
    init() {
        permutation = VoidCube()
        orientation = CentreCore()
    }
    
    // trivial scrambles does not contain wide moves or cube rotations
    init(top: CubeColor, front: CubeColor, scrambleTrivial: String) {
        permutation = VoidCube()
        permutation.scrambleCube(scrambleTrivial)
        orientation = CentreCore(top: top, front: front)
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
            orientation.rotateXPrime()
            fallthrough
        case .M2:
            orientation.rotateXPrime()
            fallthrough
        case .M:
            orientation.rotateXPrime()
            break; 
        case .S:
            orientation.rotateZPrime()
            fallthrough
        case .S2:
            orientation.rotateZPrime()
            fallthrough
        case .SPrime:
            orientation.rotateZPrime()
            break; 
        case .E:
            orientation.rotateYPrime()
            fallthrough
        case .E2:
            orientation.rotateYPrime()
            fallthrough
        case .EPrime:
            orientation.rotateYPrime()
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
        print(temp)
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
    
    public func rotate (top: CubeColor, front: CubeColor) {
        if top == orientation.front {
            rotate(.x)
        } else if top == oppositeColor(orientation.front) {
            rotate(.xPrime)
        } else if top == oppositeColor(orientation.top) {
            rotate(.x2)
        } else if top ==
            rightSideColor(top: orientation.top, front: orientation.front) {
            rotate(.zPrime)
        } else if top ==
            leftSideColor(top: orientation.top, front: orientation.front) {
            rotate(.z)
        }
        
        if front == oppositeColor(orientation.front) {
            rotate(.y2)
        } else if front ==
            rightSideColor(top: orientation.top, front: orientation.front) {
            rotate(.y)
        } else if
            front == leftSideColor(top: orientation.top, front: orientation.front) {
            rotate(.yPrime)
        }
    }
    
    // check if under the same orientation the cubes are the same
    public func solved() -> Bool {
        let cube = Cube()
        cube.rotate(top: orientation.top, front: orientation.front)
        return self == cube
    }
    
    public func at(_ pos: CornerPosition) -> CornerSticker {
        return permutation.at(pos)
    }
    
    public func at(_ pos: EdgePosition) -> EdgeSticker {
        return permutation.at(pos)
    }
    
    private func rotateXPrime() {
        permutation.turn(.RPrime)
        permutation.turn(.M)
        permutation.turn(.L)
        orientation.rotateXPrime()
    }
    
    private func rotateYPrime() {
        permutation.turn(.UPrime)
        permutation.turn(.EPrime)
        permutation.turn(.D)
        orientation.rotateYPrime()
    }
    
    private func rotateZPrime() {
        permutation.turn(.FPrime)
        permutation.turn(.SPrime)
        permutation.turn(.B)
        orientation.rotateZPrime()
    }
    
    private var permutation : VoidCube
    private var orientation : CentreCore
}
