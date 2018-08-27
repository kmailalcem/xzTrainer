//
//  CubeView.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/10/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

@IBDesignable
class CubeFaceView: UIView {
    
    var cornerColors: [CGColor] = [CGColor](repeating: UIColor.red.cgColor, count: 4)
    var edgeColors: [CGColor] = [CGColor](repeating: UIColor.yellow.cgColor, count: 4)
    var centerColor: CGColor = UIColor.red.cgColor

    func setColors(cornerColors: [CGColor],
                   edgeColors: [CGColor], centerColor: CGColor) {
        self.cornerColors = cornerColors
        self.edgeColors = edgeColors
        self.centerColor = centerColor
        commonInit(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(frame: frame)
    }
    
    private func commonInit(frame: CGRect) {
        for i in 0 ..< 3 {
            for j in 0 ..< 3 {
                let length = min(frame.width / 3, frame.height / 3)
                let cubieFrame = CGRect(x: CGFloat(i) * length, y: CGFloat(j) * length, width: length, height: length)
                let view = UIView(frame: cubieFrame)
                view.layer.borderWidth = 1
                view.layer.borderColor = UIColor.black.cgColor
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
                view.backgroundColor = UIColor(cgColor: color)
                addSubview(view)
            }
        }
    }
}
