//
//  PublicEnums.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/5/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

let NUM_STICKERS = 24

public enum CornerSticker : Int {
    case UFL = 0, FLU, LUF  // ABC
    case ULB, LBU, BUL      // DEF
    case UBR, BRU, RUB      // GHI
    case URF, RFU, FUR      // JKL
    case DLF, LFD, FDL      // WMN
    case DBL, BLD, LDB      // OPQ
    case DRB, RBD, BDR      // RST
    case DFR, FRD, RDF      // XYZ
}

public enum EdgeSticker : Int {
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

public enum Turn : String {
    case R = "R", RPrime = "R'", R2 = "R2"
    case U = "U", UPrime = "U'", U2 = "U2"
    case B = "B", BPrime = "B'", B2 = "B2"
    case L = "L", LPrime = "L'", L2 = "L2"
    case D = "D", DPrime = "D'", D2 = "D2"
    case F = "F", FPrime = "F'", F2 = "F2"
    case M = "M", MPrime = "M'", M2 = "M2"
    case S = "S", SPrime = "S'", S2 = "S2"
    case E = "E", EPrime = "E'", E2 = "E2"
}

public enum WideTurn : String {
    case Rw = "Rw", RwPrime = "Rw'", Rw2 = "Rw2"
    case Uw = "Uw", UwPrime = "Uw'", Uw2 = "Uw2"
    case Bw = "Bw", BwPrime = "Bw'", Bw2 = "Bw2"
    case Lw = "Lw", LwPrime = "Lw'", Lw2 = "Lw2"
    case Dw = "Dw", DwPrime = "Dw'", Dw2 = "Dw2"
    case Fw = "Fw", FwPrime = "Fw'", Fw2 = "Fw2"
}

public enum Rotation : String {
    case x = "x", xPrime = "x'", x2 = "x2"
    case y = "y", yPrime = "y'", y2 = "y2"
    case z = "z", zPrime = "z'", z2 = "z2"
}

public enum CubeColor {
    case WHITE, YELLOW, GREEN, BLUE, RED, ORANGE
    static let allValues = [WHITE, YELLOW, GREEN, BLUE, RED, ORANGE]
}

// absolute position on the cube
// this avoids the confusion of, for example, whether the
// UF piece refer to the piece currently in the UF position
// or the white green piece in a nonscrambled, normally oriented cube
public typealias CornerPosition = CornerSticker
public typealias EdgePosition = EdgeSticker

