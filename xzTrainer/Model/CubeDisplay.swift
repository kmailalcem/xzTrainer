//
//  CubeOrientation.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

enum CubeColor {
    case WHITE, YELLOW, GREEN, BLUE, RED, ORANGE
}

struct CubeOrientation {
    private var up, forward : CubeColor
    init(top : CubeColor, front : CubeColor) {
        up = top
        forward = front
    }
}

class CubeDisplay {
    private var orientation : CubeOrientation
    init() {
        orientation = CubeOrientation (top : .WHITE, front : .GREEN)
    }
    
    private func oppositeColor (_ color : CubeColor) -> CubeColor {
        switch(color) {
        case .WHITE:
            return .YELLOW
        case .YELLOW:
            return .WHITE
        case .GREEN:
            return .BLUE
        case .BLUE:
            return .GREEN
        case .RED:
            return .ORANGE
        case .ORANGE:
            return .RED
        }
    }
}


