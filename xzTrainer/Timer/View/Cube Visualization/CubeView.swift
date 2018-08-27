//
//  CubeView.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/13/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

//@IBDesignable
class CubeView: UIView {

    var backFace: CubeFaceView = CubeFaceView()
    var rightFace: CubeFaceView = CubeFaceView()
    var bottomFace: CubeFaceView = CubeFaceView()
    var topFace: CubeFaceView = CubeFaceView()
    var frontFace: CubeFaceView = CubeFaceView()
    var leftFace: CubeFaceView = CubeFaceView()
    
    private var _cube = Cube()
    private var _colors = ColorScheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var frame: CGRect {
        didSet {
            DispatchQueue.main.async {
                self.settingFrame()
            }
        }
    }
    
    var cube : Cube {
        get {
            return _cube
        }
        set {
            _cube = newValue
            updateFaces()
        }
    }
    
    var colorScheme : ColorScheme {
        get {
            return _colors
        } set {
            _colors = newValue
            updateFaces()
        }
    }
    
    public func settingFrame() {
        for view in [frontFace, backFace, topFace, bottomFace, leftFace, rightFace] {
            view.removeFromSuperview()
        }
        
        let length: CGFloat = min(frame.width / 4.3, frame.height / 3.2)
        let spacing = length / 10
        
        var leadingOffset, topOffset: CGFloat
        
        if (frame.width / 4.3 < frame.height / 3.2) {
            // width is limiting, so pin to left and right
            topOffset = (frame.height - length * 3.2) / 2
            leadingOffset = 0
        } else {
            // height is limiting, so pin to top and bottom
            topOffset = 0
            leadingOffset = (frame.width - length * 4.3) / 2
        }
        
        leftFace = CubeFaceView(frame: CGRect(x: leadingOffset, y: topOffset + length + spacing, width: length, height: length))
        frontFace = CubeFaceView(frame: CGRect(x: leadingOffset + length + spacing, y: leftFace.frame.minY, width: length, height: length))
        rightFace = CubeFaceView(frame: CGRect(x:  leadingOffset + length * 2 + spacing * 2, y: leftFace.frame.minY, width: length, height: length))
        backFace = CubeFaceView(frame: CGRect(x: leadingOffset + length * 3 + spacing * 3, y: leftFace.frame.minY, width: length, height: length))
        topFace = CubeFaceView(frame: CGRect(x: frontFace.frame.minX, y: topOffset, width: length, height: length))
        bottomFace = CubeFaceView(frame: CGRect(x: frontFace.frame.minX, y: frontFace.frame.maxY + spacing, width: length, height: length))
        for view in [frontFace, backFace, topFace, bottomFace, leftFace, rightFace] {
            addSubview(view)
        }
        updateFaces()
    }
    
    public func updateFaces() {
        backFace.setColors(
            cornerColors: backCornerColors(of: _cube, withScheme: _colors),
            edgeColors: backEdgeColors(of: _cube, withScheme: _colors),
            centerColor: _colors.scheme[_cube.colorCenterBack()]!)
        frontFace.setColors(
            cornerColors: frontCornerColors(of: _cube, withScheme: _colors),
            edgeColors: frontEdgeColors(of: _cube, withScheme: _colors),
            centerColor: _colors.scheme[_cube.colorCenterFront()]!)
        rightFace.setColors(
            cornerColors: rightCornerColors(of: _cube, withScheme: _colors),
            edgeColors: rightEdgeColors(of: _cube, withScheme: _colors),
            centerColor:_colors.scheme[_cube.colorCenterRight()]!)
        leftFace.setColors(
            cornerColors: leftCornerColors(of: _cube, withScheme: _colors),
            edgeColors: leftEdgeColors(of: _cube, withScheme: _colors),
            centerColor:_colors.scheme[_cube.colorCenterLeft()]!)
        topFace.setColors(
            cornerColors: topCornerColors(of: _cube, withScheme: _colors),
            edgeColors: topEdgeColors(of: _cube, withScheme: _colors),
            centerColor:_colors.scheme[_cube.colorCenterTop()]!)
        bottomFace.setColors(
            cornerColors: bottomCornerColors(of: _cube, withScheme: _colors),
            edgeColors: bottomEdgeColors(of: _cube, withScheme: _colors),
            centerColor:_colors.scheme[_cube.colorCenterBottom()]!)
        
        for face in [backFace, frontFace, rightFace, leftFace, topFace, bottomFace] {
            face.setNeedsDisplay()
            face.layoutIfNeeded()
        }
    }
    
    public func showScramble(_ scramble: String) {
        let cubeTemp = Cube()
        cubeTemp.scrambleCube(scramble)
        cube = cubeTemp
    }
    
    public func hideFacesExceptTop() {
        backFace.alpha = 0
        leftFace.alpha = 0
        rightFace.alpha = 0
        frontFace.alpha = 0
        bottomFace.alpha = 0
    }
    
    public func showAllFaces() {
        backFace.alpha = 1
        leftFace.alpha = 1
        rightFace.alpha = 1
        frontFace.alpha = 1
        bottomFace.alpha = 1
    }
    

}
