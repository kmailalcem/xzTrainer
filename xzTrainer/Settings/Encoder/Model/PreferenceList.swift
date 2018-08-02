//
//  PreferenceList.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/26/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class PreferenceList {
    private var basicEdgePreferenceList: [EdgePosition] = []
    private var basicCornerPreferenceList: [CornerPosition] = []
    private var advancedEdgePreferenceList: [EdgePosition : [EdgePosition]] = [:]
    private var advancedCornerPreferenceList: [CornerPosition : [CornerPosition]] = [:]
    
    var edgePreferenceAsFirstLetter: [EdgePosition] {
        get {
            return basicEdgePreferenceList
        }
        set {
            basicEdgePreferenceList = newValue
        }
    }
    
    var cornerPreferenceAsFirstLetter: [CornerPosition] {
        get {
            return basicCornerPreferenceList
        }
        set {
            basicCornerPreferenceList = newValue
        }
    }
    
    var edgePreferenceAsSecondLetter: [EdgePosition : [EdgePosition]] {
        get {
            return advancedEdgePreferenceList
        }
        set {
            if newValue.count != NUM_STICKERS {
                print("warning: invalid edge preference list")
                print(newValue)
            }
            advancedEdgePreferenceList = newValue
        }
    }
    
    var cornerPreferenceAsSecondLetter: [CornerPosition : [CornerPosition]] {
        get {
            return advancedCornerPreferenceList
        }
        set {
            if newValue.count != NUM_STICKERS {
                print("warning: invalid corner preference list")
                print(newValue)
            }
            advancedCornerPreferenceList = newValue
        }
    }
    
    private func move<T: Equatable>(piece: T, in pieces: inout [T], toEnd: Bool) {
        if let index = pieces.index(of: piece) {
            pieces.remove(at: index)
            if toEnd {
                pieces.append(piece)
            } else {
                pieces.insert(piece, at: 0)
            }
        }
    }

    private func move(edge: EdgePosition, forStarting edgePiece: EdgePosition? = nil, toEnd: Bool) {
        if edgePiece == nil {
            move(piece: edge, in: &basicEdgePreferenceList, toEnd: toEnd)
        } else {
            var target = advancedEdgePreferenceList[edgePiece!]!
            move(piece: edge, in: &target, toEnd: toEnd)
            advancedEdgePreferenceList[edgePiece!] = target
        }
    }
    
    private func move(corner: CornerPosition, forStarting cornerPiece: CornerPosition? = nil, toEnd: Bool) {
        if cornerPiece == nil {
            move(piece: corner, in: &basicCornerPreferenceList, toEnd: toEnd)
        } else {
            var target = advancedCornerPreferenceList[cornerPiece!]!
            move(piece: corner, in: &target, toEnd: toEnd)
            advancedCornerPreferenceList[cornerPiece!] = target
        }
    }
    
    public func prefers(_ edges: [EdgePosition], forStarting edgePiece: EdgePosition? = nil) {
        for edge in edges.reversed() {
            move(edge: edge, forStarting: edgePiece, toEnd: false)
        }
        
    }
    
    public func prefers(_ corners: [CornerPosition], forStarting cornerPiece: CornerPosition? = nil) {
        for corner in corners.reversed() {
            move(corner: corner, forStarting: cornerPiece, toEnd: false)
        }
    }
    
    public func avoids(_ edges: [EdgePosition], forStarting edgePiece: EdgePosition? = nil) {
        for edge in edges.reversed() {
            move(edge: edge, forStarting: edgePiece, toEnd: true)
        }
    }
    
    public func avoids(_ corners: [CornerPosition], forStarting cornerPiece: CornerPosition? = nil) {
        for corner in corners.reversed() {
            move(corner: corner, forStarting: cornerPiece, toEnd: true)
        }
    }
    
    public func swap(i: Int, j: Int, for edge: EdgeSticker? = nil) {
        if edge == nil {
            basicEdgePreferenceList.swapAt(i, j)
        } else {
            var target = advancedEdgePreferenceList[edge!]!
            target.swapAt(i, j)
            advancedEdgePreferenceList[edge!] = target
        }
    }
    
    public func swap(i: Int, j: Int, for corner: CornerSticker? = nil) {
        if corner == nil {
            basicCornerPreferenceList.swapAt(i, j)
        } else {
            var target = advancedCornerPreferenceList[corner!]!
            target.swapAt(i, j)
            advancedCornerPreferenceList[corner!] = target
        }
    }
    
    public func reloadSecondLetters() {
        for i in 0 ..< NUM_STICKERS {
            let edge = EdgePosition(rawValue: i)!
            let corner = CornerPosition(rawValue: i)!
            advancedEdgePreferenceList[edge] = basicEdgePreferenceList
            advancedCornerPreferenceList[corner] = basicCornerPreferenceList
        }
    }
    
    init() {
        for i in 0 ..< NUM_STICKERS {
            let edge = EdgePosition(rawValue: i)!
            let corner = CornerPosition(rawValue: i)!
            basicEdgePreferenceList.append(edge)
            basicCornerPreferenceList.append(corner)
        }
        basicEdgePreferenceList = basicEdgePreferenceList.removeBuffer()
        basicCornerPreferenceList = basicCornerPreferenceList.removeBuffer()
        reloadSecondLetters()
    }
}
