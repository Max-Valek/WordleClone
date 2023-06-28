//
//  Guess.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

struct Guess {
    
    let index: Int
    // initially just 5 spaces
    var word = "     "
    // backgrounds for characters
    var bgColors = [Color](repeating: .systemBackground, count: 5)
    // whether the character is flipped
    var cardFlipped = [Bool](repeating: false, count: 5)
    // array of characters in the word (convert to strings)
    var guessLetters: [String] {
        word.map { String($0) }
    }
}
