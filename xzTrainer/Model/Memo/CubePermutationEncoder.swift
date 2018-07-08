//
//  Solver.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/7/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

extension Cube {
    func at(_ pos: EdgePosition, parityFilter: AdvancedParity) -> EdgeSticker {
        let parityPiece1 = parityFilter.parityEdgePiece1.rawValue / 2
        let parityPiece2 = parityFilter.parityEdgePiece2.rawValue / 2
        let targetPiece = at(pos).rawValue / 2
        let pieceOffset = at(pos).rawValue % 2
        if parityFilter.isActivated && targetPiece == parityPiece2 {
            return EdgeSticker(rawValue: parityPiece1 * 2 + pieceOffset)!
        } else if parityFilter.isActivated && targetPiece == parityPiece1 {
            return EdgeSticker(rawValue: parityPiece2 * 2 + pieceOffset)!
        } else {
            return at(pos)
        }
    }
    
}

class CubePermutationEncoder {

    

    var formattedEdgeMemo: String {
        let trimmedEdgeMemo = edgeMemo.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedEdgeFlips = ""
        if edgeFlips.count > 0 {
            trimmedEdgeFlips = " (" + edgeFlips.trimmingCharacters(in: .whitespacesAndNewlines)
                + ")"
        }
        return trimmedEdgeMemo + trimmedEdgeFlips
    }
    
    var formattedCornerMemo: String {
        let trimmedCornerMemo = cornerMemo.trimmingCharacters(in: .whitespacesAndNewlines)
        var trimmedCornerTwist = ""
        if cornerTwists.count > 0 {
            trimmedCornerTwist = " (" +  cornerTwists.trimmingCharacters(in: .whitespacesAndNewlines)
                + ")"
        }
        return trimmedCornerMemo + trimmedCornerTwist
    }
    
    init(forCube cube: Cube) {
        self.cube = cube
        cube.rotate(top: .WHITE, front: .GREEN)
    }
    
    init(forScramble scramble: String) {
        cube.scrambleCube(scramble)
        cube.rotate(top: .WHITE, front: .GREEN)
    }
    
    var edgeMemo: String {
        if hasParity == nil {
            setUpParity()
        }
        encodeEdge()
        return translateEdgePermutationToMemoCode()
    }
    
    var cornerMemo: String {
        if hasParity == nil {
           setUpParity()
        }
        return translateCornerPermutationToMemoCode()
    }
    
    var edgeFlips: String {
        encodeEdgeFlips()
        return translateEdgeFlipsToMemoCode()
    }
    
    var cornerTwists: String {
        encodeCornerTwists()
        return translateCornerTwistsToMemoCode()
    }
    
    private func setUpParity() {
        encodeCorner()
        hasParity = (cornerPermutation.count % 2 == 1)
        encoderSetting.advancedParity.isActivated =
            encoderSetting.advancedParity.isEnabled && hasParity!
    }
    
    private func translateEdgePermutationToMemoCode() -> String {
        var edgeMemo = ""
        var needInsertSpace = false
        for sticker in edgePermutation {
            if !belongsToSamePiece(sticker, edgeBuffer) {
                edgeMemo.append(letterScheme.edgeScheme[sticker]!)
                if needInsertSpace {
                    edgeMemo.append(" ")
                    needInsertSpace = false
                } else {
                    needInsertSpace = true
                }
            }
        }
        return edgeMemo
    }
    
    private func encodeEdge() {
        initializeUnsolvedEdgePieces()
        edgeCycleStartingSticker = edgeBuffer
        repeat {
            appendEdgeCycle()
            edgeCycleStartingSticker = getNextUnsolvedEdgePiece()
        } while edgeCycleStartingSticker != nil
    }
    
    private func initializeUnsolvedEdgePieces() {
        unsolvedEdgeStickers = [EdgePosition?](repeating: nil, count: NUM_STICKERS)
        for i in 0 ..< NUM_STICKERS {
            let edge = EdgePosition(rawValue: i)!
            if !isInPlace(piece: edge) {
                unsolvedEdgeStickers[i] = edge
            } 
        }
    }
    
    private  func isInPlace(piece: EdgePosition) -> Bool {
        return piece.rawValue / 2 == cube.at(piece, parityFilter:
            encoderSetting.advancedParity).rawValue / 2
    }
    
    private func appendEdgeCycle() {
        appendAndSolve(edgeCycleStartingSticker!)
        edgeStickerTracker = cube.at(edgeCycleStartingSticker!, parityFilter:
            encoderSetting.advancedParity)
        while !requiresEdgeCycleBreak() {
            appendAndSolve(edgeStickerTracker)
            edgeStickerTracker = cube.at(edgeStickerTracker, parityFilter:
                encoderSetting.advancedParity)
        }
        appendAndSolve(edgeStickerTracker)
    }
    
    private func appendAndSolve(_ edge: EdgePosition) {
        edgePermutation.append(edge)
        let firstStickerOnPiece = edge.rawValue / 2 * 2
        let secondStickerOnPiece = edge.rawValue / 2 * 2 + 1
        unsolvedEdgeStickers[firstStickerOnPiece] = nil
        unsolvedEdgeStickers[secondStickerOnPiece] = nil
    }
    
    private func getNextUnsolvedEdgePiece() -> EdgePosition? {
        for pieces in userPreference.edgePreferenceAsFirstLetter {
            if let result = unsolvedEdgeStickers[pieces.rawValue] {
                return result
            }
        }
        return nil
    }
    
    private func requiresEdgeCycleBreak() -> Bool {
        return belongsToSamePiece(edgeCycleStartingSticker!, edgeStickerTracker)
    }
    
    private func belongsToSamePiece(
        _ sticker1: EdgeSticker, _ sticker2: EdgeSticker) -> Bool {
        return sticker1.rawValue / 2 == sticker2.rawValue / 2
    }
    
    private func translateCornerPermutationToMemoCode() -> String {
        var cornerMemo = ""
        var needInsertSpace = false
        for sticker in cornerPermutation {
            if !belongsToSamePiece(sticker, cornerBuffer) {
                cornerMemo.append(letterScheme.cornerScheme[sticker]!)
                
                if needInsertSpace {
                    cornerMemo.append(" ")
                    needInsertSpace = false
                } else {
                    needInsertSpace = true
                }
            }
        }
        return cornerMemo
    }
    
    private func encodeCorner() {
        initializeUnsolvedCornerPieces()
        cornerCycleStartingSticker = cornerBuffer
        repeat {
            appendCornerCycle()
            cornerCycleStartingSticker = getNextUnsolvedCornerPiece()
        } while cornerCycleStartingSticker != nil
    }
    
    private func initializeUnsolvedCornerPieces() {
        unsolvedCornerStickers = [CornerPosition?](repeating: nil, count: NUM_STICKERS)
        for i in 0 ..< NUM_STICKERS {
            let corner = CornerPosition(rawValue: i)!
            if !isInPlace(piece: corner) {
                unsolvedCornerStickers[i] = corner
            }
        }
    }
    
    private  func isInPlace(piece: CornerPosition) -> Bool {
        return piece.rawValue / 3 == cube.at(piece).rawValue / 3
    }
    
    private func appendCornerCycle() {
        appendAndSolve(cornerCycleStartingSticker!)
        cornerStickerTracker = cube.at(cornerCycleStartingSticker!)
        while !requiresCornerCycleBreak() {
            appendAndSolve(cornerStickerTracker)
            cornerStickerTracker = cube.at(cornerStickerTracker)
        }
        appendAndSolve(cornerStickerTracker)
    }
    
    private func appendAndSolve(_ corner: CornerPosition) {
        cornerPermutation.append(corner)
        let firstStickerOnPiece = corner.rawValue / 3 * 3
        let secondStickerOnPiece = firstStickerOnPiece + 1
        let thirdStickerOnPiece = firstStickerOnPiece + 2
        unsolvedCornerStickers[firstStickerOnPiece] = nil
        unsolvedCornerStickers[secondStickerOnPiece] = nil
        unsolvedCornerStickers[thirdStickerOnPiece] = nil
    }
    
    private func getNextUnsolvedCornerPiece() -> CornerPosition? {
        for piece in userPreference.cornerPrefereneceAsFirstLetter {
            if let result = unsolvedCornerStickers[piece.rawValue] {
                return result
            }
        }
        return nil
    }
    
    private func requiresCornerCycleBreak() -> Bool {
        return belongsToSamePiece(cornerCycleStartingSticker!, cornerStickerTracker)
    }
    
    private func belongsToSamePiece(
        _ sticker1: CornerSticker, _ sticker2: CornerSticker) -> Bool {
        return sticker1.rawValue / 3 == sticker2.rawValue / 3
    }
    
    private func encodeEdgeFlips() {
        if edgeFlipsInAbsolutePosition.count != 0 {
            return
        }
        
        for i in 0 ..<  NUM_STICKERS / 2 {
            
            let edge = EdgePosition(rawValue: i * 2)!
            if !belongsToSamePiece(edge, edgeBuffer) {
                if isFlipped(edge: edge) {
                    edgeFlipsInAbsolutePosition.append(edge)
                }
            }
        }
    }
    
    private func isFlipped(edge: EdgePosition) -> Bool {
        return !pieceIsSolved(edge: edge) && isInPlace(piece: edge)
    }
    
    private func pieceIsSolved(edge: EdgePosition) -> Bool {
        return edge == cube.at(edge, parityFilter: encoderSetting.advancedParity)
    }
    
    private func encodeCornerTwists() {
        if cornerTwistsInAbsolutePosition.count != 0 {
            return
        }
        
        for i in 0 ..< NUM_STICKERS / 3 {
            let corner = CornerPosition(rawValue: i * 3)!
            if !belongsToSamePiece(corner, cornerBuffer) {
                if isTwisted(corner: corner) {
                    cornerTwistsInAbsolutePosition.append(corner)
                }
            }
        }
    }
    
    private func isTwisted(corner: CornerPosition) -> Bool {
        return !pieceIsSolved(corner: corner) && isInPlace(piece: corner)
    }
    
    private func pieceIsSolved(corner: CornerPosition) -> Bool {
        return corner == cube.at(corner)
    }
    
    private func translateEdgeFlipsToMemoCode() -> String {
        var result = ""
        for sticker in edgeFlipsInAbsolutePosition {
            result.append(letterScheme.edgeScheme[sticker]!)
            result.append(" ")
        }
        return result
    }
    
    private func translateCornerTwistsToMemoCode() -> String {
        var result = ""
        for sticker in cornerTwistsInAbsolutePosition {
            result.append(letterScheme.cornerScheme[sticker]!)
            result.append(cornerTwistDirection(sticker))
            result.append(" ")
        }
        return result
    }
    
    private func cornerTwistDirection(_ corner: CornerPosition) -> String {
        if cube.at(corner).rawValue == corner.rawValue + 1 {
            return ""
        } else {
            return "'"
        }
    }
    
    private var hasParity: Bool?
   
    private var cube: Cube = Cube()
    
    private var edgePermutation: [EdgePosition] = []
    private var edgeStickerTracker: EdgePosition!
    private var edgeCycleStartingSticker: EdgePosition?
    private var unsolvedEdgeStickers: [EdgePosition?] = []
    
    private var cornerPermutation: [CornerPosition] = []
    private var cornerStickerTracker: CornerPosition!
    private var cornerCycleStartingSticker: CornerPosition?
    private var unsolvedCornerStickers: [CornerPosition?] = []
    
    private var edgeFlipsInAbsolutePosition: [EdgePosition] = []
    private var cornerTwistsInAbsolutePosition: [CornerPosition] = []
    
    private var letterScheme = UserSetting.shared.general.letterScheme
    private var userPreference = UserSetting.shared.encoder.userPreference
    private var encoderSetting = UserSetting.shared.encoder
    private let edgeBuffer = UserSetting.shared.general.edgeBuffer
    private let cornerBuffer = UserSetting.shared.general.cornerBuffer
}
