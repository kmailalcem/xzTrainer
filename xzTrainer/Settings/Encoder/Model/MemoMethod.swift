//
//  SettingsAndHandlers.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/29/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

class MemoMethod {
    private var _name: String
    private var _options: [MemoPreference]
    private var _edgeBuffer: EdgeSticker?
    private var _cornerBuffer: CornerSticker?
    
    var name: String {
        get {
            return _name
        }
    }
    
    var options: [MemoPreference] {
        get {
            return _options
        }
    }
    
    var applicable: Bool {
        if _edgeBuffer != nil {
            return UserSetting.shared.general.edgeBuffer == _edgeBuffer!
        }
        if _cornerBuffer != nil {
            return UserSetting.shared.general.cornerBuffer == _cornerBuffer!
        }
        
        // no specifically required buffers
        return true
    }
    
    var requiredBuffer: String {
        if _edgeBuffer != nil {
            return toString(_edgeBuffer!)
        } else if _cornerBuffer != nil {
            return toString(_cornerBuffer!)
        } else {
            return "none"
        }
    }
    
    init(name: String,
         requiredEdgeBuffer: EdgeSticker?,
         requiredCornerBuffer: CornerSticker?,
         options: [MemoPreference]) {
        self._name = name
        self._options = options
        self._edgeBuffer = requiredEdgeBuffer
        self._cornerBuffer = requiredCornerBuffer
    }
}

