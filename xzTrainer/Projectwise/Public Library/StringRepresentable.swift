//
//  StringRepresentable.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/17/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

public protocol StringRepresentable {
    var string: String { get }
}

public enum CubeColor: Int, StringRepresentable {
    public var string: String {
        switch self {
        case .WHITE:
            return "White"
        case .YELLOW:
            return "Yellow"
        case .GREEN:
            return "Green"
        case .BLUE:
            return "Blue"
        case .RED:
            return "Red"
        case .ORANGE:
            return "Orange"
        }
    }
    
    case WHITE, YELLOW, GREEN, BLUE, RED, ORANGE
    static let allValues = [WHITE, YELLOW, GREEN, BLUE, RED, ORANGE]
}

extension EdgeSticker: StringRepresentable {
    public var string: String {
        switch self {
        case .BD: return "BD"
        case .BL: return "BL"
        case .BR: return "BR"
        case .BU: return "BU"
        case .DB: return "DB"
        case .DF: return "DF"
        case .DL: return "DL"
        case .DR: return "DR"
        case .RB: return "RB"
        case .RD: return "RD"
        case .RF: return "RF"
        case .RU: return "RU"
        case .LB: return "LB"
        case .LF: return "LF"
        case .LU: return "LU"
        case .LD: return "LD"
        case .FD: return "FD"
        case .FU: return "FU"
        case .FL: return "FL"
        case .FR: return "FR"
        case .UB: return "UB"
        case .UF: return "UF"
        case .UL: return "UL"
        case .UR: return "UR"
        }
    }
}

extension CornerSticker: StringRepresentable {
    public var string: String {
        switch self {
        case .UFL: return "UFL"
        case .FLU: return "FLU"
        case .LUF: return "LUF"
        case .ULB: return "ULB"
        case .LBU: return "LBU"
        case .BUL: return "BUL"
        case .UBR: return "UBR"
        case .BRU: return "BRU"
        case .RUB: return "RUB"
        case .URF: return "URF"
        case .RFU: return "RFU"
        case .FUR: return "FUR"
        case .DLF: return "DLF"
        case .LFD: return "LFD"
        case .FDL: return "FDL"
        case .DBL: return "DBL"
        case .BLD: return "BLD"
        case .LDB: return "LDB"
        case .DRB: return "DRB"
        case .RBD: return "RBD"
        case .BDR: return "BDR"
        case .DFR: return "DFR"
        case .FRD: return "FRD"
        case .RDF: return "RDF"
        }
    }
}
