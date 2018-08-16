//
//  GeneralSettings.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 7/7/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit



class GeneralSetting {
    let edgeBufferKey = "Edge Buffer"
    let cornerBufferKey = "Corner Buffer"
    let topColorKey = "Top Color"
    let frontColorKey = "Front Color"
    let nameKey = "User Name"
    
    var edgeBuffer: EdgePosition = .DF {
        didSet {
            UserDefaults.standard.set(edgeBuffer.rawValue, forKey: edgeBufferKey)
        }
    }
    var cornerBuffer: CornerPosition = .ULB {
        didSet {
            UserDefaults.standard.set(cornerBuffer.rawValue, forKey: cornerBufferKey)
        }
    }
    var name: String {
        get {
            if keyExists(nameKey) {
                return UserDefaults.standard.string(forKey: nameKey)!
            } else {
                return LocalizationGeneral.defaultUserName.localized
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    
    var letterScheme = LetterScheme()
    var colorScheme = ColorScheme()
    
    var topFaceColor: CubeColor = .YELLOW {
        didSet {
            UserDefaults.standard.set(topFaceColor.rawValue, forKey: topColorKey)
        }
    }
    
    var frontFaceColor: CubeColor = .RED {
        didSet {
            UserDefaults.standard.set(frontFaceColor.rawValue, forKey: frontColorKey)
        }
    }
    
    init() {
        if let buffer = UserDefaults.standard.object(forKey: edgeBufferKey) as? Int {
            edgeBuffer = EdgePosition(rawValue: buffer)!
        }
        
        if let buffer = UserDefaults.standard.object(forKey: cornerBufferKey) as? Int {
            cornerBuffer = CornerPosition(rawValue: buffer)!
        }
        
        if let top = UserDefaults.standard.object(forKey: topColorKey) as? Int {
            topFaceColor = CubeColor(rawValue: top)!
        }
        
        if let front = UserDefaults.standard.object(forKey: frontColorKey) as? Int {
            frontFaceColor = CubeColor(rawValue: front)!
        }
    }
}
