//
//  TurnsAndRotations.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/17/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

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
    
    static let allValues = [R, RPrime, R2, U, UPrime, U2, B, BPrime, B2, L, LPrime, L2, D, DPrime, D2, F, FPrime, F2, M, MPrime, M2, S, SPrime, S2, E, EPrime, E2]
    
    static let allStandardValues = [R, RPrime, R2, U, UPrime, U2, B, BPrime, B2, L, LPrime, L2, D, DPrime, D2, F, FPrime, F2]
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

