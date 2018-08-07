//
//  CubeOrientation.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/1/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

class CentreCore : Equatable {
    private var _top, _front : CubeColor
    
    var top : CubeColor {
        get {
            return _top
        }
    }
    
    var front : CubeColor{
        get {
            return _front
        }
    }
    
    init() {
        _top = .WHITE
        _front = .GREEN
    }
    
    init(top: CubeColor, front: CubeColor) {
        if (top == oppositeColor(front)) {
            print("top and front cannot be opposite colors")
            exit(1)
        }
        _top = top
        _front = front
    }
    
    public func rotateXPrime() {
        let temp = oppositeColor(_front)
        _front = _top
        _top = temp
    }
    
    public func rotateYPrime() {
        _front = leftSideColor(top: top, front: front)
    }
    
    public func rotateZPrime() {
        _top = rightSideColor(top: top, front: front)
    }
    
    public static func == (lhs: CentreCore, rhs: CentreCore) -> Bool {
        return lhs.top == rhs.top && lhs.front == rhs.front
    }
}

public func oppositeColor (_ color : CubeColor) -> CubeColor {
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

public func rightSideColor (top : CubeColor, front : CubeColor)
    -> CubeColor
{
    var top = top; var front = front;
    if (top == oppositeColor(front)) {
        print("top and front color must not be opposite colors")
        exit(1)
    }
    
    // rotate the cube to keep right side color
    if front == .WHITE {
        front = oppositeColor(top)
        top = .WHITE
    } else if top == .YELLOW {
        front = oppositeColor(front)
        top = .WHITE
    }else if front == .YELLOW {
        front = top
        top = .WHITE
    }
    
    // may assume that either top is white
    // or neither is white or yellow
    switch ((top, front)) {
    case (.WHITE, .GREEN):
        return .RED
    case (.WHITE, .RED):
        return .BLUE
    case (.WHITE, .BLUE):
        return .ORANGE
    case (.WHITE, .ORANGE):
        return .GREEN
    case (.RED, .GREEN), (.GREEN, .ORANGE),
         (.ORANGE, .BLUE), (.BLUE, .RED):
        return .YELLOW
    default:
        return .WHITE
    }
}

public func leftSideColor (top: CubeColor, front: CubeColor) -> CubeColor {
    return oppositeColor(rightSideColor(top: top, front: front))
}
