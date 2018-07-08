//
//  LetterScheme.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 5/22/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import Foundation

class LetterScheme {
    var edgeScheme: Dictionary<EdgeSticker, String>
    var cornerScheme: Dictionary<CornerSticker, String>

    init(edgeSchemeLetters: String, cornerSchemeLetters: String) {
        let edgeLetters = edgeSchemeLetters.split(separator: " ")
        let cornerLetters = cornerSchemeLetters.split(separator: " ")
        edgeScheme = Dictionary<EdgeSticker, String>()
        cornerScheme = Dictionary<CornerSticker, String>()
        
        for i in 0 ..< NUM_STICKERS {
            edgeScheme[EdgeSticker(rawValue: i)!] = String(edgeLetters[i])
            cornerScheme[CornerSticker(rawValue: i)!] = String(cornerLetters[i])
        }
    }
    
    convenience init() {
        self.init(
            edgeSchemeLetters: "A B C D E F G H I J K L M N O P Q R S T W X Y U",
            cornerSchemeLetters: "A B C D E F G H I J K L W M N O P Q R S T X Y U")
    }
    
    func setLetter(forPiece piece: EdgePosition, as char: String) {
        edgeScheme[piece] = char
    }
    
    func setLetter(forPiece piece: CornerPosition, as char: String) {
        cornerScheme[piece] = char
    }
}
