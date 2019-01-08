//
//  DropDownTextField.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/30/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class DropDownTextField: UITextField {
    @objc func themeSetUp() {
        DispatchQueue.main.async {
            self.rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 10, height: 30))
            imageView.image = #imageLiteral(resourceName: "DropDown")
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
            view.addSubview(imageView)
            self.rightView = view
            imageView.tintColor = Theme.current.backgroundTintColor
            self.tintColor = .clear
        }
    }
    
    func becomeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        becomeObserver()
        themeSetUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
