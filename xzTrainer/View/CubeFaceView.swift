//
//  CubeView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/10/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

@IBDesignable
class CubeFaceView: UIView {
    
    //@IBInspectable
    var cornerColors: [CGColor] = [CGColor](repeating: UIColor.red.cgColor, count: 4)
    //@IBInspectable
    var edgeColors: [CGColor] = [CGColor](repeating: UIColor.yellow.cgColor, count: 4)
    //@IBInspectable
    var centerColor: CGColor = UIColor.red.cgColor

    /*
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }*/
    
    func setColors(cornerColors: [CGColor],
                   edgeColors: [CGColor], centerColor: CGColor) {
        self.cornerColors = cornerColors
        self.edgeColors = edgeColors
        self.centerColor = centerColor
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()!
        context.addRect(CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
        context.setStrokeColor(red:0, green:0, blue:0, alpha:1)
        context.setLineWidth(2)
        context.strokePath()
        showFaceFillView(context: context, frame: rect)
    }
    
    
    func drawRectWithoutBorder(context: CGContext, x: CGFloat, y:CGFloat,
                               width: CGFloat, height: CGFloat, color: CGColor)
    {
        context.addRect(CGRect(x: x, y: y,
                               width: width, height: height))
        context.setFillColor(color)
        context.fillPath()
    }
    
    func drawBorder(context: CGContext, x: CGFloat, y:CGFloat,
                  width: CGFloat, height: CGFloat)
    {
        context.addRect(CGRect(x: x, y: y,
                               width: width, height: height))
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
    }
    
    func showFaceFillView(context: CGContext, frame: CGRect)
    {
        let sideLength = frame.width / 3
        for i in 0 ..< 3 {
            for j in 0 ..< 3{
                let startX = frame.minX + CGFloat(i) * sideLength
                let startY = frame.minY + CGFloat(j) * sideLength
                let color : CGColor
                switch (i, j) {
                case (0, 0):
                    color = cornerColors[0]
                case (1, 0):
                    color = edgeColors[0]
                case (2, 0):
                    color = cornerColors[1]
                case (0, 1):
                    color = edgeColors[1]
                case (1, 1):
                    color = centerColor
                case (2, 1):
                    color = edgeColors[2]
                case (0, 2):
                    color = cornerColors[2]
                case (1, 2):
                    color = edgeColors[3]
                case (2, 2):
                    color = cornerColors[3]
                default:
                    print("more than 3x3 color")
                    exit(1)
                }
                drawRectWithoutBorder(context: context, x: startX, y: startY,
                                      width: sideLength, height: sideLength,
                                      color: color)
                drawBorder(context: context, x: startX, y: startY,
                           width: sideLength, height: sideLength)
            }
        }
    }
}
