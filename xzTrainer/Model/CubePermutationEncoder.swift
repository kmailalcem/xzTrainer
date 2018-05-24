//
//  Solver.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/7/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class CubePermutationEncoder {
    // default to M2 for edges and Old Pochmann for corners
    public let edgeBuffer: EdgePosition = .DF
    public let cornerBuffer: CornerPosition = .ULB
    
    init(forCube cube: Cube) {
        self.cube = cube
    }
    
    init(forScramble scramble: String) {
        cube.scrambleCube(scramble)
    }
    
    var edgeMemo: String {
        encodeEdge()
        return translateEdgePermutationToMemoCode()
    }
    
    var cornerMemo: String {
        encodeCorner()
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
        return piece.rawValue / 2 == cube.at(piece).rawValue / 2
    }
    
    private func appendEdgeCycle() {
        appendAndSolve(edgeCycleStartingSticker!)
        edgeStickerTracker = cube.at(edgeCycleStartingSticker!)
        while !requiresEdgeCycleBreak() {
            appendAndSolve(edgeStickerTracker)
            edgeStickerTracker = cube.at(edgeStickerTracker)
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
        for i in 0 ..< NUM_STICKERS {
            if let result = unsolvedEdgeStickers[i] {
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
        for i in 0 ..< NUM_STICKERS {
            if let result = unsolvedCornerStickers[i] {
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
        for i in 0 ..<  NUM_STICKERS / 2 {
            let edge = EdgePosition(rawValue: i * 2)!
            if isFlipped(edge: edge) {
                edgeFlipsInAbsolutePosition.append(edge)
            }
        }
    }
    
    private func isFlipped(edge: EdgePosition) -> Bool {
        return !pieceIsSolved(edge: edge) && isInPlace(piece: edge)
    }
    
    private func pieceIsSolved(edge: EdgePosition) -> Bool {
        return edge == cube.at(edge)
    }
    
    private func encodeCornerTwists() {
        for i in 0 ..< NUM_STICKERS / 3 {
            let corner = CornerPosition(rawValue: i * 3)!
            if isTwisted(corner: corner) {
                cornerTwistsInAbsolutePosition.append(corner)
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
    
    private var letterScheme: LetterScheme = LetterScheme()
    private var cube: Cube = Cube()
    private var encoderSetting: EncoderSetting = EncoderSetting()
    
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
    
}
