//
//  MemoSettings.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation



class EncoderSetting {
    
    private var preferenceList = PreferenceList()
    
    var userPreference: PreferenceList {
        get {
            if userCustomizeOrder {
                readPreferenceList()
            } else {
                processMemoStyle()
            }
            return preferenceList
        }
    }
    
    var advancedParity = AdvancedParity()
    var userMemoStyle: [MemoPreference] = []
    
    private let customizeKey = "UserCustomizeOrder"
    private let firstEdgePreferenceKey = "firstEdges"
    private let firstCornerPreferenceKey = "firstCorners"
    private let secondEdgePreferenceKey = "secondEdges"
    private let secondCornerPreferenceKey = "secondCorners"
    
    var userCustomizeOrder: Bool {
        get {
            if keyExists(customizeKey) {
                return UserDefaults.standard.bool(forKey: customizeKey)
            } else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: customizeKey)
            if newValue {
                savePreferenceList()
            }
        }
    }
    
    private func processMemoStyle() {
        preferenceList = PreferenceList()
        userMemoStyle.sort { (lhs, rhs) -> Bool in
            lhs.priority < rhs.priority
        }
        
        for preference in userMemoStyle {
            let temp = preference.preferredFirstEdge
            preferenceList.prefers(temp)
            preferenceList.prefers(preference.preferredFirstCorner)
            preferenceList.avoids(preference.avoidedFirstEdge)
            preferenceList.avoids(preference.avoidedFirstCorner)
        }
        preferenceList.reloadSecondLetters()
        for preference in userMemoStyle {
            for i in 0 ..< NUM_STICKERS {
                let edge = EdgeSticker(rawValue: i)!
                let corner = CornerSticker(rawValue: i)!
                preferenceList.prefers(preference.preferredSecondEdge(for: edge), forStarting: edge)
                preferenceList.prefers(preference.preferredSecondCorner(for: corner), forStarting: corner)
                preferenceList.avoids(preference.avoidedSecondEdge(for: edge), forStarting: edge)
                preferenceList.avoids(preference.avoidedSecondCorner(for: corner), forStarting: corner)
            }
        }
    }
    
    private func savePreferenceList() {
        UserDefaults.standard.set(preferenceList.edgePreferenceAsFirstLetter.map({ (piece) -> Int in
            return piece.rawValue
        }), forKey: firstEdgePreferenceKey)
        
        UserDefaults.standard.set(preferenceList.cornerPrefereneceAsFirstLetter.map({ (piece) -> Int in
            return piece.rawValue
        }), forKey: firstCornerPreferenceKey)
        
        for i in 0 ..< NUM_STICKERS {
            let edge = EdgeSticker(rawValue: i)!
            let corner = CornerSticker(rawValue: i)!
            let savableEdges = NSArray(array: preferenceList.edgePreferenceAsSecondLetter[edge]!.map({ (piece) -> Int in
                return piece.rawValue
            }))
            let savableCorners = NSArray(array: preferenceList.cornerPreferenceAsSecondLetter[corner]!.map({ (piece) -> Int in
                return piece.rawValue
            }))
            UserDefaults.standard.set(savableEdges, forKey: secondEdgePreferenceKey + String(i))
            UserDefaults.standard.set(savableCorners, forKey: secondCornerPreferenceKey + String(i))
        }
    }
    
    private func readPreferenceList() {
        if keyExists(firstCornerPreferenceKey) {
            let firstEdges = (UserDefaults.standard.object(forKey: firstEdgePreferenceKey) as! [Int]).map { (i) -> EdgeSticker in
                return EdgeSticker(rawValue: i)!
            }
            let firstCorners = (UserDefaults.standard.object(forKey: firstCornerPreferenceKey) as! [Int]).map { (i) -> CornerSticker in
                return CornerSticker(rawValue: i)!
            }
            preferenceList.edgePreferenceAsFirstLetter = firstEdges
            preferenceList.cornerPrefereneceAsFirstLetter = firstCorners
        }
        
        var edgePreference = [EdgeSticker : [EdgeSticker]]()
        var cornerPreference = [CornerSticker : [CornerSticker]]()

        for i in 0 ..< NUM_STICKERS {
            let savableEdges = UserDefaults.standard.object(forKey: secondEdgePreferenceKey + String(i)) as! [Int]
            let savableCorners = UserDefaults.standard.object(forKey: secondCornerPreferenceKey + String(i)) as! [Int]
            let edge = EdgeSticker(rawValue: i)!
            let corner = CornerSticker(rawValue: i)!
            edgePreference[edge] = savableEdges.map({ (j) -> EdgeSticker in
                return EdgeSticker(rawValue: j)!
            })
            cornerPreference[corner] = savableCorners.map({ (j) -> CornerSticker in
                return CornerSticker(rawValue: j)!
            })
        }
        
        preferenceList.edgePreferenceAsSecondLetter = edgePreference
        preferenceList.cornerPreferenceAsSecondLetter = cornerPreference
    }
    
    public func activateSetting(_ memoPreference: MemoPreference) {
        let memoKey = type(of: memoPreference).memoKey
        UserDefaults.standard.set(true, forKey: memoKey)
        userMemoStyle.append(memoPreference)

    }
    
    public func deactivateSetting(_ memoPreference: MemoPreference) {
        for i in 0 ..< userMemoStyle.count {
            if type(of: userMemoStyle[i]) == type(of: memoPreference) {
                userMemoStyle.remove(at: i)
                UserDefaults.standard.set(false, forKey: type(of: memoPreference).memoKey)
                break
            }
        }
    }
    
    init() {
        for style in allMemoStyles {
            let memoKey = type(of: style).memoKey
            if UserDefaults.standard.object(forKey: memoKey) != nil && UserDefaults.standard.bool(forKey: memoKey) {
                userMemoStyle.append(style)
            }
        }
    }
}



