//
//  GradientView.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/14/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class GradientView: UIView {

    var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
    }

}
