//
//  PieceArrayExtentsion.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/2/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

extension Array where Element == EdgeSticker {
    public func removeBuffer() -> [EdgeSticker] {
        var result = self
        for i in (0 ..< count).reversed() {
            if result[i].rawValue / 2 == UserSetting.shared.general.edgeBuffer.rawValue / 2 {
                result.remove(at: i)
            }
        }
        return result
    }
}

extension Array where Element == CornerSticker {
    public func removeBuffer() -> [CornerSticker] {
        var result = self
        for i in (0 ..< count).reversed() {
            if result[i].rawValue / 3 == UserSetting.shared.general.cornerBuffer.rawValue / 3 {
                result.remove(at: i)
            }
        }
        return result
    }
}
