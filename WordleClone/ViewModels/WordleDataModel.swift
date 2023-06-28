//
//  WordleDataModel.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    
    @Published var guesses: [Guess] = []
    
    var keyColors = [String : Color]()
    // words to be guessed
    var selectedWord = ""
    // word for current guess
    var currentWord = ""
    // which try they are on
    var tryIndex = 0
    var inPlay = false
    
    // true if still initial try and user hasnt typed any letters
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    // for disabling letter keys
    var disabledKeys: Bool {
        !inPlay || currentWord.count == 5
    }
    
    init() {
        newGame()
    }
    
    // MARK: - Setup
    func newGame() {
        populateDefaults()
        selectedWord = Global.commonWords.randomElement()!
        currentWord = ""
        inPlay = true
    }
    
    // set default values
    func populateDefaults() {
        guesses = []
        for i in 0...5 {
            guesses.append(Guess(index: i))
        }
        // reset keyboard colors
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors[String(char)] = .unused
        }
    }
    
    // MARK: - Game Play
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
        updateRow()
    }
    
    func enterWord() {
        if verifyWord() {
            print("valid word")
        } else {
            print("invalid")
        }
    }
    
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    func verifyWord() -> Bool {
        // see if word is in device's dictionary (had to select simulator dictionary: settings->general->dictionary)
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
}
