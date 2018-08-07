//
//  Cube.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 4/17/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

let NUM_STICKERS = 24

enum CornerSticker : Int {
    case UFL = 0, FLU, LUF  // ABC
    case ULB, LBU, BUL      // DEF
    case UBR, BRU, RUB      // GHI
    case URF, RFU, FUR      // JKL
    case DLF, LFD, FDL      // WMN
    case DBL, BLD, LDB      // OPQ
    case DRB, RBD, BDR      // RST
    case DFR, FRD, RDF      // XYZ
}

enum EdgeSticker : Int {
    case UF = 0, FU = 1     // AB
    case UL = 2, LU = 3     // CD
    case UB = 4, BU = 5     // EF
    case UR = 6, RU = 7     // GH
    case DF = 8, FD = 9     // IJ
    case DL = 10, LD = 11   // KL
    case DB = 12, BD = 13   // MN
    case DR = 14, RD = 15   // OP
    case FR = 16, RF = 17   // QR
    case FL = 18, LF = 19   // ST
    case BL = 20, LB = 21   // WX
    case BR = 22, RB = 23   // YZ
}


public class CubePermutation {
    // absolute position on the cube
    // this avoids the confusion of, for example, whether the
    // UF piece refer to the piece currently in the UF position
    // or the white green piece in a nonscrambled, normally oriented cube
    typealias CornerPosition = CornerSticker
    typealias EdgePosition = EdgeSticker
    
    // initializing to a solved cube, white top, green front
    // traditional letter scheme
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
    
    public func rotateRPrime () {
        movePieceWithOrientation(from: .RFU, to: .RUB)
        movePieceWithOrientation(from: .RUB, to: .RBD)
        movePieceWithOrientation(from: .RBD, to: .RDF)
        movePieceWithOrientation(from: .RF, to: .RU)
        movePieceWithOrientation(from: .RU, to: .RB)
        movePieceWithOrientation(from: .RB, to: .RD)
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
    
    private func getAdjacentPosition (_ sticker: EdgeSticker)
        -> EdgeSticker
    {
        let firstPart = sticker.rawValue / 2 * 2
        let secondPart = (sticker.rawValue + 1) % 2
        return  EdgeSticker(rawValue: firstPart + secondPart)!
    }

    private func getAdjacentPosition (_ sticker: CornerSticker)
        -> CornerSticker
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
