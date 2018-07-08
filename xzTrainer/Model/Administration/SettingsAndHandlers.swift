//
//  SettingsAndHandlers.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/29/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

class MemoMethod {
    private var _name: String
    private var _options: [MemoOption]
    
    var name: String {
        get {
            return _name
        }
    }
    
    var options: [MemoOption] {
        get {
            return _options
        }
    }
    
    init(name: String, options: [MemoOption]) {
        self._name = name
        self._options = options
    }
}

class MemoOption {
    private var _description: String
    private var _explanation: String
    
    var description: String {
        return _description
    }
    
    var explanation: String {
        return _explanation
    }
    
    init(description: String, explanation: String) {
        _description = description
        _explanation = explanation
    }
}

