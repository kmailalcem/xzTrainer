//
//  ColorScheme.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/12/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

public struct ColorScheme {
    let scheme: Dictionary<CubeColor, CGColor>
    init() {
        scheme =
            [
                .WHITE: UIColor.white.cgColor,
                .YELLOW: UIColor.yellow.cgColor,
                .GREEN: UIColor.green.cgColor,
                .BLUE: #colorLiteral(red: 0.06829141743, green: 0.373761549, blue: 0.6211334074, alpha: 1).cgColor,
                .RED: #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1).cgColor,
                .ORANGE: UIColor.orange.cgColor
        ]
    }
}

func backCornerColors (of cube: Cube,
                       withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .BRU)]!,
        scheme.scheme[cube.getColor(at: .BUL)]!,
        scheme.scheme[cube.getColor(at: .BDR)]!,
        scheme.scheme[cube.getColor(at: .BLD)]!
    ]
}

func backEdgeColors (of cube: Cube,
                     withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .BU)]!,
        scheme.scheme[cube.getColor(at: .BR)]!,
        scheme.scheme[cube.getColor(at: .BL)]!,
        scheme.scheme[cube.getColor(at: .BD)]!
    ]
}

func frontCornerColors (of cube: Cube,
                        withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .FLU)]!,
        scheme.scheme[cube.getColor(at: .FUR)]!,
        scheme.scheme[cube.getColor(at: .FDL)]!,
        scheme.scheme[cube.getColor(at: .FRD)]!
    ]
}

func frontEdgeColors (of cube: Cube,
                     withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .FU)]!,
        scheme.scheme[cube.getColor(at: .FL)]!,
        scheme.scheme[cube.getColor(at: .FR)]!,
        scheme.scheme[cube.getColor(at: .FD)]!
    ]
}

func topCornerColors (of cube: Cube,
                    withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .ULB)]!,
        scheme.scheme[cube.getColor(at: .UBR)]!,
        scheme.scheme[cube.getColor(at: .UFL)]!,
        scheme.scheme[cube.getColor(at: .URF)]!
    ]
}

func topEdgeColors (of cube: Cube,
                    withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .UB)]!,
        scheme.scheme[cube.getColor(at: .UL)]!,
        scheme.scheme[cube.getColor(at: .UR)]!,
        scheme.scheme[cube.getColor(at: .UF)]!
    ]
}

func bottomCornerColors (of cube: Cube,
                         withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .DLF)]!,
        scheme.scheme[cube.getColor(at: .DFR)]!,
        scheme.scheme[cube.getColor(at: .DBL)]!,
        scheme.scheme[cube.getColor(at: .DRB)]!
    ]
}

func bottomEdgeColors (of cube: Cube,
                      withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .DF)]!,
        scheme.scheme[cube.getColor(at: .DL)]!,
        scheme.scheme[cube.getColor(at: .DR)]!,
        scheme.scheme[cube.getColor(at: .DB)]!
    ]
}

func leftCornerColors (of cube: Cube,
                      withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .LBU)]!,
        scheme.scheme[cube.getColor(at: .LUF)]!,
        scheme.scheme[cube.getColor(at: .LDB)]!,
        scheme.scheme[cube.getColor(at: .LFD)]!
    ]
}

func leftEdgeColors (of cube: Cube,
                     withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .LU)]!,
        scheme.scheme[cube.getColor(at: .LB)]!,
        scheme.scheme[cube.getColor(at: .LF)]!,
        scheme.scheme[cube.getColor(at: .LD)]!
    ]
}

func rightCornerColors (of cube: Cube,
                        withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .RFU)]!,
        scheme.scheme[cube.getColor(at: .RUB)]!,
        scheme.scheme[cube.getColor(at: .RDF)]!,
        scheme.scheme[cube.getColor(at: .RBD)]!
    ]
}

func rightEdgeColors (of cube: Cube,
                      withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: .RU)]!,
        scheme.scheme[cube.getColor(at: .RF)]!,
        scheme.scheme[cube.getColor(at: .RB)]!,
        scheme.scheme[cube.getColor(at: .RD)]!
    ]
}

