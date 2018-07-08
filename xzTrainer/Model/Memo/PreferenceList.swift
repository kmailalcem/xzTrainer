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
    
    var edgePreferenceAsFirstLetter: [EdgePosition] {
        get {
            return basicEdgePreferenceList
        }
    }
    
    var cornerPrefereneceAsFirstLetter: [CornerPosition] {
        get {
            return basicCornerPreferenceList
        }
    }
    
    private func prefers(_ edge: EdgePosition) {
        basicEdgePreferenceList.remove(at: basicEdgePreferenceList.index(of: edge)!)
        basicEdgePreferenceList.insert(edge, at: 0)
    }
    
    private func prefers(_ corner: CornerPosition) {
        basicCornerPreferenceList.remove(at: basicCornerPreferenceList.index(of: corner)!)
        basicCornerPreferenceList.insert(corner, at: 0)
    }
    
    private func avoid(_ edge: EdgePosition) {
        basicEdgePreferenceList.remove(at: basicEdgePreferenceList.index(of: edge)!)
        basicEdgePreferenceList.append(edge)
    }
    
    private func avoid(_ corner: CornerPosition) {
        basicCornerPreferenceList.remove(at: basicCornerPreferenceList.index(of: corner)!)
        basicCornerPreferenceList.append(corner)
    }
    
    public func prefers(_ edges: [EdgePosition]) {
        for edge in edges {
            prefers(edge)
        }
    }
    
    public func prefers(_ corners: [CornerPosition]) {
        for corner in corners {
            prefers(corner)
        }
    }
    
    public func avoids(_ edges: [EdgePosition]) {
        for edge in edges {
            avoid(edge)
        }
    }
    
    public func avoids(_ corners: [CornerPosition]) {
        for corner in corners {
            avoid(corner)
        }
    }
    
    init() {
        for i in 0 ..< NUM_STICKERS {
            basicEdgePreferenceList.append(EdgePosition(rawValue: i)!)
            basicCornerPreferenceList.append(CornerPosition(rawValue: i)!)
        }
    }
}
