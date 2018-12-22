//
//  CubePieces.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/17/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

let NUM_STICKERS = 24

public protocol CubePiece: StringRepresentable {
    var rawValue: Int { get }
    init?(rawValue: Int)
    static var faceCount: Int { get }
    static var pieceName: String { get }
}

public enum CornerSticker :Int, CubePiece {
    public static var pieceName: String {
        return "Corner".localized()
    }
    
    public static var allValues: [CornerSticker] {
        return [.UFL, .FLU, .LUF, .ULB, .LBU, .BUL, .UBR, .BRU, .RUB, .URF, .RFU, .FUR, .DLF, .LFD, .FDL, .DBL, .BLD, .LDB, .DRB, .RBD, .BDR, .DFR, .FRD, .RDF]
    }
    
    public static var faceCount: Int {
        return 3
    }
    
    case UFL = 0, FLU, LUF  // ABC
    case ULB, LBU, BUL      // DEF
    case UBR, BRU, RUB      // GHI
    case URF, RFU, FUR      // JKL
    case DLF, LFD, FDL      // WMN
    case DBL, BLD, LDB      // OPQ
    case DRB, RBD, BDR      // RST
    case DFR, FRD, RDF      // XYZ
}

public enum EdgeSticker : Int, CubePiece {
    public static var pieceName: String {
        return "Edge".localized()
    }
    
    public static var allValues: [EdgeSticker] {
        return [UF, FU, UL, LU, UB, BU, UR, RU, DF, FD, DL, LD, DB, BD, DR, RD, FR, RF, FL, LF, BL, LB, BR, RB]
    }
    
    
    public static var faceCount: Int {
        return 2
    }
    
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


