//
//  Cube.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

public class VoidCube : Equatable {
    public static func == (lhs: VoidCube, rhs: VoidCube) -> Bool {
        for i in 0 ..< NUM_STICKERS {
            if (lhs.edges[i] != rhs.edges[i] ||
                lhs.corners[i] != rhs.corners[i]) {
                return false
            }
        }
        return true
    }
    
    // initializing to a solved cube, white top, green front
    // traditional letter schemes
    public init() {
        edges = Array(repeating: .UF, count: NUM_STICKERS)
        corners = Array(repeating: .UFL, count: NUM_STICKERS)
        
        for i in 0 ..< NUM_STICKERS {
            edges[i] = EdgePosition(rawValue: i)!
            corners[i] = CornerPosition(rawValue: i)!
        }
        
        cornerLetterScheme = "ABCDEFGHIJKLWMNOPQRSTXYZ"
        edgeLetterScheme = "ABCDEFGHIJKLMNOPQRSTWXYZ"
    }
    
    public func scrambleCube(_ scramble: String) {
        let turnsInScramble = scramble.replacingOccurrences(of: "’", with:
            "'").split(separator: " ")
        for turnString in turnsInScramble {
            if let aTurn = Turn(rawValue: String(turnString)) {
                turn(aTurn)
            } else {
                print("Invalid move: \(String(turnString))")
                exit(1)
            }
        }
    }
    
    public func getSticker(at pos: EdgePosition) -> EdgeSticker {
        return edges[pos.rawValue]
    }
    
    public func getSticker(at pos: CornerPosition) -> CornerSticker {
        return corners[pos.rawValue]
    }
    
    public func turn(_ turning: Turn) {
        switch(turning) {
        case .R:
            rotateRPrime();
            fallthrough
        case .R2:
            rotateRPrime()
            fallthrough
        case .RPrime:
            rotateRPrime()
            break;
        case .U:
            rotateUPrime()
            fallthrough
        case .U2:
            rotateUPrime()
            fallthrough
        case .UPrime:
            rotateUPrime()
            break;
        case .L:
            rotateLPrime()
            fallthrough
        case .L2:
            rotateLPrime()
            fallthrough
        case .LPrime:
            rotateLPrime()
            break;
        case .B:
            rotateBPrime()
            fallthrough
        case .B2:
            rotateBPrime()
            fallthrough
        case .BPrime:
            rotateBPrime()
            break;
        case .F:
            rotateFPrime()
            fallthrough
        case .F2:
            rotateFPrime()
            fallthrough
        case .FPrime:
            rotateFPrime()
            break;
        case .D:
            rotateDPrime()
            fallthrough
        case .D2:
            rotateDPrime()
            fallthrough
        case .DPrime:
            rotateDPrime()
            break;
        case .M:
            rotateMPrime()
            fallthrough
        case .M2:
            rotateMPrime()
            fallthrough
        case .MPrime:
            rotateMPrime()
            break;
        case .S:
            rotateSPrime()
            fallthrough
        case .S2:
            rotateSPrime()
            fallthrough
        case .SPrime:
            rotateSPrime()
            break;
        case .E:
            rotateEPrime()
            fallthrough
        case .E2:
            rotateEPrime()
            fallthrough
        case .EPrime:
            rotateEPrime()
            break;
        }
    }
    
    public func at(_ pos: CornerPosition) -> CornerSticker {
        return corners[pos.rawValue]
    }
    
    public func at(_ pos: EdgePosition) -> EdgeSticker {
        return edges[pos.rawValue]
    }
    
    private func rotateRPrime () {
        movePieceWithOrientation(from: .RFU, to: .RUB)
        movePieceWithOrientation(from: .RUB, to: .RBD)
        movePieceWithOrientation(from: .RBD, to: .RDF)
        movePieceWithOrientation(from: .RF, to: .RU)
        movePieceWithOrientation(from: .RU, to: .RB)
        movePieceWithOrientation(from: .RB, to: .RD)
    }
    
    private func rotateUPrime () {
        movePieceWithOrientation(from: .UFL, to: .ULB)
        movePieceWithOrientation(from: .ULB, to: .UBR)
        movePieceWithOrientation(from: .UBR, to: .URF)
        movePieceWithOrientation(from: .UF, to: .UL)
        movePieceWithOrientation(from: .UL, to: .UB)
        movePieceWithOrientation(from: .UB, to: .UR)
    }
    
    private func rotateLPrime() {
        movePieceWithOrientation(from: .LUF, to: .LFD)
        movePieceWithOrientation(from: .LFD, to: .LDB)
        movePieceWithOrientation(from: .LDB, to: .LBU)
        movePieceWithOrientation(from: .LU, to: .LF)
        movePieceWithOrientation(from: .LF, to: .LD)
        movePieceWithOrientation(from: .LD, to: .LB)
    }
    
    private func rotateBPrime() {
        movePieceWithOrientation(from: .BUL, to: .BLD)
        movePieceWithOrientation(from: .BLD, to: .BDR)
        movePieceWithOrientation(from: .BDR, to: .BRU)
        movePieceWithOrientation(from: .BU, to: .BL)
        movePieceWithOrientation(from: .BL, to: .BD)
        movePieceWithOrientation(from: .BD, to: .BR)
    }
    
    private func rotateFPrime() {
        movePieceWithOrientation(from: .FLU, to: .FUR)
        movePieceWithOrientation(from: .FUR, to: .FRD)
        movePieceWithOrientation(from: .FRD, to: .FDL)
        movePieceWithOrientation(from: .FU, to: .FR)
        movePieceWithOrientation(from: .FR, to: .FD)
        movePieceWithOrientation(from: .FD, to: .FL)
    }

    private func rotateDPrime() {
        movePieceWithOrientation(from: .DLF, to: .DFR)
        movePieceWithOrientation(from: .DFR, to: .DRB)
        movePieceWithOrientation(from: .DRB, to: .DBL)
        movePieceWithOrientation(from: .DF, to: .DR)
        movePieceWithOrientation(from: .DR, to: .DB)
        movePieceWithOrientation(from: .DB, to: .DL)
    }
    
    private func rotateMPrime() {
        movePieceWithOrientation(from: .FU, to: .DF)
        movePieceWithOrientation(from: .DF, to: .BD)
        movePieceWithOrientation(from: .BD, to: .UB)
    }
    
    private func rotateSPrime() {
        movePieceWithOrientation(from: .UR, to: .RD)
        movePieceWithOrientation(from: .RD, to: .DL)
        movePieceWithOrientation(from: .DL, to: .LU)
    }
    
    private func rotateEPrime() {
        movePieceWithOrientation(from: .RF, to: .FL)
        movePieceWithOrientation(from: .FL, to: .LB)
        movePieceWithOrientation(from: .LB, to: .BR)
    }
    
    public func printCube () {
        print("Edges:\t ", terminator: "")
        for edgeSticker in edges {
            print("\(edgeSticker.rawValue) ", terminator: "")
        }
        print("\n")
        print("Corners:\t ", terminator: "")
        for cornerSticker in corners {
            print("\(cornerSticker.rawValue) ", terminator: "")
        }
        print("\n")
    }
    
    func assertCornerEqual(to answer: [Int]) -> Bool {
        for i in 0 ..< NUM_STICKERS {
            if corners[i].rawValue != answer[i] {
                return false
            }
        }
        return true
    }
    
    func assertEdgeEqual(to answer: [Int]) -> Bool {
        for i in 0 ..< NUM_STICKERS {
            if edges[i].rawValue != answer[i] {
                return false
            }
        }
        return true
    }
    
    private func getAdjacentPosition (_ sticker: EdgePosition)
        -> EdgePosition
    {
        let firstPart = sticker.rawValue / 2 * 2
        let secondPart = (sticker.rawValue + 1) % 2
        return  EdgeSticker(rawValue: firstPart + secondPart)!
    }

    private func getAdjacentPosition (_ sticker: CornerPosition)
        -> CornerPosition
    {
        let firstPart = sticker.rawValue / 3 * 3
        let secondPart = (sticker.rawValue + 1) % 3
        return  CornerSticker(rawValue: firstPart + secondPart)!
    }

    private func movePieceWithOrientation (from source: EdgePosition,
                                           to target: EdgePosition) {
        edges.swapAt(source.rawValue, target.rawValue)
        edges.swapAt(getAdjacentPosition(source).rawValue,
                     getAdjacentPosition(target).rawValue)
    }

    private func movePieceWithOrientation (from source: CornerPosition,
                                           to target: CornerPosition) {
        let sourceNext = getAdjacentPosition(source)
        let sourceNextNext = getAdjacentPosition(sourceNext)
        let targetNext = getAdjacentPosition(target)
        let targetNextNext = getAdjacentPosition(targetNext)
        corners.swapAt(source.rawValue, target.rawValue)
        corners.swapAt(sourceNext.rawValue, targetNext.rawValue)
        corners.swapAt(sourceNextNext.rawValue, targetNextNext.rawValue)
 
    }

    private var edges : [EdgeSticker]
    private var corners : [CornerSticker]
    private var cornerLetterScheme : String!
    private var edgeLetterScheme : String!
    
}
