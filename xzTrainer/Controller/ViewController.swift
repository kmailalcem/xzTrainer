//
//  ViewController.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 4/17/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var backFace: CubeFaceView!
    @IBOutlet var rightFace: CubeFaceView!
    @IBOutlet var leftFace: CubeFaceView!
    @IBOutlet var bottomFace: CubeFaceView!
    @IBOutlet var frontFace: CubeFaceView!
    @IBOutlet var topFace: CubeFaceView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = ColorScheme()
        let cube = Cube(top: CubeColor.RED,
                        front: CubeColor.YELLOW, scrambleTrivial: "R U R' U' R' F R2 U' R' U' R U R' F'")
        backFace.setColors(
            cornerColors: backCornerColors(of: cube, withScheme: colors),
            edgeColors: backEdgeColors(of: cube, withScheme: colors),
            centerColor: colors.scheme[cube.colorBack()]!)
        frontFace.setColors(
            cornerColors: frontCornerColors(of: cube, withScheme: colors),
            edgeColors: frontEdgeColors(of: cube, withScheme: colors),
            centerColor: colors.scheme[cube.colorFront()]!)
        rightFace.setColors(
            cornerColors: rightCornerColors(of: cube, withScheme: colors),
            edgeColors: rightEdgeColors(of: cube, withScheme: colors),
            centerColor:colors.scheme[cube.colorRight()]!)
        leftFace.setColors(
            cornerColors: leftCornerColors(of: cube, withScheme: colors),
            edgeColors: leftEdgeColors(of: cube, withScheme: colors),
            centerColor:colors.scheme[cube.colorLeft()]!)
        topFace.setColors(
            cornerColors: topCornerColors(of: cube, withScheme: colors),
            edgeColors: topEdgeColors(of: cube, withScheme: colors),
            centerColor:colors.scheme[cube.colorTop()]!)
        bottomFace.setColors(
            cornerColors: bottomCornerColors(of: cube, withScheme: colors),
            edgeColors: bottomEdgeColors(of: cube, withScheme: colors),
            centerColor:colors.scheme[cube.colorBottom()]!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

