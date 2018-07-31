//
//  DropDownTextField.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 7/30/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

class DropDownTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 10, height: 30))
        imageView.image = #imageLiteral(resourceName: "DropDown")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        view.addSubview(imageView)
        rightView = view
        imageView.tintColor = #colorLiteral(red: 0.2823529412, green: 0.4196078431, blue: 0.568627451, alpha: 1)
        tintColor = .clear
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
