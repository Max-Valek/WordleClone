//
//  Guess.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

/// Represents one word guessed by the user
struct Guess {
    // which guess it was (0...5+)
    let index: Int
    // initially just 5 spaces
    var word = "     "
    // background for each character
    var bgColors = [Color](repeating: .systemBackground, count: 5)
    // whether the character is flipped
    var cardFlipped = [Bool](repeating: false, count: 5)
    // array of characters in the word (convert to strings)
    var guessLetters: [String] {
        word.map { String($0) }
    }
}
