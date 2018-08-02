//
//  MemoPreference.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/1/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

protocol MemoPreference {
    static var memoKey: String { get }
    static var description: String { get }
    static var explanation: String { get }
    var isEdgeMethod: Bool { get }
    var isPreferringMethod: Bool { get }
    var defaultPriority: Int { get }
    var priority: Int { get }
    var preferredFirstEdge: [EdgePosition] { get }
    var preferredFirstCorner: [CornerPosition] { get }
    var avoidedFirstEdge: [EdgePosition] { get }
    var avoidedFirstCorner: [CornerPosition] { get }
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition]
    func preferredSecondCorner(for first: CornerPosition) -> [CornerPosition]
    func avoidedSecondEdge(for first: EdgePosition) -> [EdgePosition]
    func avoidedSecondCorner(for first: CornerPosition) -> [CornerPosition]
}

extension MemoPreference {
    var priority: Int {
        get {
            if keyExists(Self.memoKey + "Priority") {
                return UserDefaults.standard.integer(forKey: Self.memoKey + "Priority")
            }
            return defaultPriority
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.memoKey + "Priority")
        }
        
    }
    
    var preferredFirstEdge: [EdgePosition] { get { return [] } }
    
    var preferredFirstCorner: [CornerPosition] { get { return [] } }
    
    var avoidedFirstEdge: [EdgePosition] { get { return [] } }
    
    var avoidedFirstCorner: [CornerPosition] { get { return [] } }
    
    func preferredSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        return []
    }
    
    func preferredSecondCorner(for first: CornerPosition) -> [CornerPosition] {
        return []
    }
    
    func avoidedSecondEdge(for first: EdgePosition) -> [EdgePosition] {
        return []
    }
    
    func avoidedSecondCorner(for first: CornerPosition) -> [CornerPosition] {
        return []
    }
}
