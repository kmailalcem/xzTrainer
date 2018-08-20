//
//  TimerVCSessionManager.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/21/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

extension TimerVC {
    
    @objc func sessionTablePopIn() {
        view.addSubview(sessionTable)
        sessionTable.center = view.center
        UIView.animate(withDuration: 0.2) {
            self.sessionTable.alpha = 1
        }
    }
}
