//
//  WordleDataModel.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    
    @Published var guesses: [Guess] = []
    @Published var incorrectAttempts = [Int](repeating: 0, count: 6)    // for shake animation
    
    var keyColors = [String : Color]()      // color for each keyboard key
    var selectedWord = ""       // word to be guessed
    var currentWord = ""        // word user is currently typing
    var tryIndex = 0            // which try they are on
    var inPlay = false          // if game has been set up
    
    // started if not first try or user has inputted letters
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    // disable letter keys if game not set up or input is full length
    var disabledKeys: Bool {
        !inPlay || currentWord.count == 5
    }
    
    init() {
        newGame()
    }
    
    // MARK: - Setup
    
    // set defaults, select random word, inplay = true
    func newGame() {
        populateDefaults()
        selectedWord = Global.commonWords.randomElement()!
        currentWord = ""
        inPlay = true
    }
    
    // set guesses to be default Guess array and set all key colors to unused
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
    
    // letter key pressed
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
        updateRow()
    }
    
    // enter key pressed
    func enterWord() {
        if verifyWord() {
            print("valid word")
        } else {
            withAnimation {
                self.incorrectAttempts[tryIndex] += 1
            }
            incorrectAttempts[tryIndex] = 0
        }
    }
    
    // backspace pressed
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    // update guess row with current input, spaces at end if not full 5 letters
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    // true if word is in device's dictionary
    // (had to select simulator dictionary: settings->general->dictionary)
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
}
