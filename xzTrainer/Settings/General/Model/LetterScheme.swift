//
//  LetterScheme.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 5/22/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import Foundation

let edgeSchemeKey = "Edge Scheme"
let cornerSchemeKey = "Corner Scheme"

class LetterScheme {
    static let speffzCornerString = "D I F A E R B Q N C M J U G L X S H W O T V K P"
    static let speffzEdgeString = "C I D E A Q B M U K X G W S V O J P L F R H T N"
    static let traditionalCornerString = "A B C D E F G H I J K L W M N O P Q R S T X Y Z"
    static let traditionalEdgeString = "A B C D E F G H I J K L M N O P Q R S T W X Y Z"
    
    private var edgeScheme: Dictionary<EdgeSticker, String> {
        didSet {
            for i in 0 ..< edgeScheme.count {
                let edgeKey = "Edge \(i)"
                UserDefaults.standard.set(edgeScheme[EdgePosition(rawValue: i)!]!, forKey: edgeKey)
            }
        }
    }
    
    private var cornerScheme: Dictionary<CornerSticker, String> {
        didSet {
            for i in 0 ..< cornerScheme.count {
                let cornerKey = "Corner \(i)"
                UserDefaults.standard.set(cornerScheme[CornerPosition(rawValue: i)!]!, forKey: cornerKey)
            }
        }
    }
    
    subscript<T: CubePiece>(_ pos: T) -> String {
        get {
            if pos is CornerSticker {
                return cornerScheme[pos as! CornerSticker]!
            } else {
                return edgeScheme[pos as! EdgeSticker]!
            }
        }
        set {
            if pos is CornerSticker {
                cornerScheme[pos as! CornerSticker] = newValue
            } else {
                edgeScheme[pos as! EdgeSticker] = newValue
            }
        }
    }

    public func useSpeffz() {
        parseEdgeString(LetterScheme.speffzEdgeString)
        parseCornerString(LetterScheme.speffzCornerString)
    }
    
    public func useTraditional() {
        parseEdgeString(LetterScheme.traditionalEdgeString)
        parseCornerString(LetterScheme.traditionalCornerString)
    }
    
    init(edgeSchemeLetters: String, cornerSchemeLetters: String) {
        edgeScheme = Dictionary<EdgeSticker, String>()
        cornerScheme = Dictionary<CornerSticker, String>()
        parseEdgeString(edgeSchemeLetters)
        parseCornerString(cornerSchemeLetters)
    }
    
    private func parseEdgeString(_ edgeSchemeLetters: String) {
        let edgeLetters = edgeSchemeLetters.split(separator: " ")
        var edgeDict = Dictionary<EdgePosition, String>()
        for i in 0 ..< NUM_STICKERS {
            edgeDict[EdgeSticker(rawValue: i)!] = String(edgeLetters[i])
        }
        edgeScheme = edgeDict
    }
    
    private func parseCornerString(_ cornerSchemeLetters: String) {
        let cornerLetters = cornerSchemeLetters.split(separator: " ")
        var cornerDict = Dictionary<CornerPosition, String>()
        for i in 0 ..< NUM_STICKERS {
            cornerDict[CornerSticker(rawValue: i)!] = String(cornerLetters[i])
        }
        cornerScheme = cornerDict
    }
    
    private func readEdgeScheme() {
        for i in 0 ..< NUM_STICKERS {
            let edgeKey = "Edge \(i)"
            if let code = UserDefaults.standard.object(forKey: edgeKey) as? String {
                edgeScheme[EdgePosition(rawValue: i)!] = code
            }
            // UserDefaults.standard.string(forKey: edgeKey)!
        }
    }
    
    private func readCornerScheme() {
        for i in 0 ..< NUM_STICKERS {
            let cornerKey = "Corner \(i)"
            cornerScheme[CornerPosition(rawValue: i)!] = UserDefaults.standard.string(forKey: cornerKey)
        }
    }

    init() {
        edgeScheme = Dictionary<EdgeSticker, String>()
        cornerScheme = Dictionary<CornerSticker, String>()
        
        if UserDefaults.standard.object(forKey: "Edge 0") != nil {
            readEdgeScheme()
        } else {
             parseEdgeString(LetterScheme.speffzEdgeString)
        }
        
        if UserDefaults.standard.object(forKey: "Corner 0") != nil {
            readCornerScheme()
        } else {
            parseCornerString(LetterScheme.speffzCornerString)
        }
    }
    
}
