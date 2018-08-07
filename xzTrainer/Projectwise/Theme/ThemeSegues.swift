//
//  SegueRightToLeft.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/2/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class SegueRightToLeft: UIStoryboardSegue {

    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                        src.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
                        },
                       completion: { finished in
                        src.view.transform = .identity
                        src.present(dst, animated: false, completion: nil)
                        })
    }
}

class SegueLeftToRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                        src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        },
                       completion: { finished in
                        src.view.transform = .identity
                        src.dismiss(animated: false, completion: nil)
                        
        })
    }
}
