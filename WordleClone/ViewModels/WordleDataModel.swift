//
//  WordleDataModel.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    
    @Published var guesses: [Guess] = []
    
    init() {
        newGame()
    }
    
    func newGame() {
        populateDefaults()
    }
    
    // set default values
    func populateDefaults() {
        guesses = []
        for i in 0...4 {
            guesses.append(Guess(index: i))
        }
    }
}
