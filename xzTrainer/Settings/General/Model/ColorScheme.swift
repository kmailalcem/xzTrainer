//
//  ColorScheme.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/12/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
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
        scheme.scheme[cube.getColor(at: CornerSticker.BRU)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.BUL)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.BDR)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.BLD)]!
    ]
}

func backEdgeColors (of cube: Cube,
                     withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: EdgeSticker.BU)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.BR)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.BL)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.BD)]!
    ]
}

func frontCornerColors (of cube: Cube,
                        withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: CornerSticker.FLU)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.FUR)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.FDL)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.FRD)]!
    ]
}

func frontEdgeColors (of cube: Cube,
                     withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: EdgeSticker.FU)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.FL)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.FR)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.FD)]!
    ]
}

func topCornerColors (of cube: Cube,
                    withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: CornerSticker.ULB)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.UBR)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.UFL)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.URF)]!
    ]
}

func topEdgeColors (of cube: Cube,
                    withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: EdgeSticker.UB)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.UL)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.UR)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.UF)]!
    ]
}

func bottomCornerColors (of cube: Cube,
                         withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: CornerSticker.DLF)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.DFR)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.DBL)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.DRB)]!
    ]
}

func bottomEdgeColors (of cube: Cube,
                      withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: EdgeSticker.DF)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.DL)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.DR)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.DB)]!
    ]
}

func leftCornerColors (of cube: Cube,
                      withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: CornerSticker.LBU)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.LUF)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.LDB)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.LFD)]!
    ]
}

func leftEdgeColors (of cube: Cube,
                     withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: EdgeSticker.LU)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.LB)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.LF)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.LD)]!
    ]
}

func rightCornerColors (of cube: Cube,
                        withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: CornerSticker.RFU)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.RUB)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.RDF)]!,
        scheme.scheme[cube.getColor(at: CornerSticker.RBD)]!
    ]
}

func rightEdgeColors (of cube: Cube,
                      withScheme scheme: ColorScheme) -> [CGColor] {
    return [
        scheme.scheme[cube.getColor(at: EdgeSticker.RU)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.RF)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.RB)]!,
        scheme.scheme[cube.getColor(at: EdgeSticker.RD)]!
    ]
}

