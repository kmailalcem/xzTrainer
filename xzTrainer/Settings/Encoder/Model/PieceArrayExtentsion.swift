//
//  PieceArrayExtentsion.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 8/2/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

extension Array where Element == EdgeSticker {
    public func removeBuffer(_ buffer: EdgeSticker) -> [EdgeSticker] {
        var result = self
        for i in (0 ..< count).reversed() {
            if result[i].rawValue / 2 == buffer.rawValue / 2 {
                result.remove(at: i)
            }
        }
        return result
    }
    public func removeBuffer() -> [EdgeSticker] {
        return removeBuffer(UserSetting.shared.general.edgeBuffer)
    }
}

extension Array where Element == CornerSticker {
    public func removeBuffer(_ buffer: CornerSticker) -> [CornerSticker] {
        var result = self
        for i in (0 ..< count).reversed() {
            if result[i].rawValue / 3 == buffer.rawValue / 3 {
                result.remove(at: i)
            }
        }
        return result
    }
    public func removeBuffer() -> [CornerSticker] {
        return removeBuffer(UserSetting.shared.general.cornerBuffer)
    }
}
