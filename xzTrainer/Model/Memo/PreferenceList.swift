//
//  PreferenceList.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/26/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class PreferenceList {
    private var edgePreferenceList: [EdgePosition] = []
    private var cornerPreferenceList: [CornerPosition] = []
    
    var edgePreference: [EdgePosition] {
        get {
            return edgePreferenceList
        }
    }
    
    var cornerPreferenece: [CornerPosition] {
        get {
            return cornerPreferenceList
        }
    }
    
    private func prefers(_ edge: EdgePosition) {
        edgePreferenceList.remove(at: edgePreferenceList.index(of: edge)!)
        edgePreferenceList.insert(edge, at: 0)
    }
    
    private func prefers(_ corner: CornerPosition) {
        cornerPreferenceList.remove(at: cornerPreferenceList.index(of: corner)!)
        cornerPreferenceList.insert(corner, at: 0)
    }
    
    private func avoid(_ edge: EdgePosition) {
        edgePreferenceList.remove(at: edgePreferenceList.index(of: edge)!)
        edgePreferenceList.append(edge)
    }
    
    private func avoid(_ corner: CornerPosition) {
        cornerPreferenceList.remove(at: cornerPreferenceList.index(of: corner)!)
        cornerPreferenceList.append(corner)
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
            edgePreferenceList.append(EdgePosition(rawValue: i)!)
            cornerPreferenceList.append(CornerPosition(rawValue: i)!)
        }
    }
}
