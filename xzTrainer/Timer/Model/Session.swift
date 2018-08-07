//
//  Session.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/20/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

extension Session {
    public func copyFrom(_ copy: Session) {
        id = copy.id
        name = copy.name
    }
}
