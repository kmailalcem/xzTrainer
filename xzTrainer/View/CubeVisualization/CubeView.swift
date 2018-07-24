//
//  CubeView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/13/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    public func layingContraint() {
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
    
    public func layingContraintBackUp() {
        for view in [backFace, frontFace, leftFace, rightFace, topFace, bottomFace] {
            view.removeConstraints(view.constraints)
        }
        
        let length: CGFloat = min(frame.width / 4.3, frame.height / 3.2)
        
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
        
        for view in [leftFace, rightFace, frontFace,
                     backFace, topFace, bottomFace] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(
                equalToConstant: length).isActive = true
            view.heightAnchor.constraint(
                equalToConstant: length).isActive = true
        }
        
        leftFace.leadingAnchor.constraint(
            equalTo: leadingAnchor, constant: leadingOffset).isActive = true
        leftFace.centerYAnchor.constraint(
            equalTo: centerYAnchor).isActive = true
        topFace.topAnchor.constraint(
            equalTo: topAnchor, constant: topOffset).isActive = true
        topFace.leadingAnchor.constraint(
            equalTo: leftFace.trailingAnchor,
            constant: length / 10).isActive = true
        
        var previousView = topFace
        for view in [frontFace, bottomFace] {
            view.leadingAnchor.constraint(
                equalTo: leftFace.trailingAnchor,
                constant: length / 10).isActive = true
            view.topAnchor.constraint(
                equalTo: previousView.bottomAnchor,
                constant: length / 10).isActive = true
            previousView = view
        }
        
        previousView = frontFace
        for view in [rightFace, backFace] {
            view.leadingAnchor.constraint(
                equalTo: previousView.trailingAnchor,
                constant: length / 10).isActive = true
            view.centerYAnchor.constraint(
                equalTo: centerYAnchor).isActive = true
            previousView = view
        }
        
        updateFaces()
        setNeedsLayout()
        layoutIfNeeded()
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
        }
    }
    
    public func showScramble(_ scramble: String) {
        let cubeTemp = Cube()
        cubeTemp.scrambleCube(scramble)
        cube = cubeTemp
    }
    
    public func hideFacesExceptFront() {
        backFace.alpha = 0
        leftFace.alpha = 0
        rightFace.alpha = 0
        topFace.alpha = 0
        bottomFace.alpha = 0
    }
    
    public func showAllFaces() {
        backFace.alpha = 1
        leftFace.alpha = 1
        rightFace.alpha = 1
        topFace.alpha = 1
        bottomFace.alpha = 1
    }
    

}
