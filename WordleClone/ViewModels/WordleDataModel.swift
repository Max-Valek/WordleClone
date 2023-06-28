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
    var selectedWord = ""                   // word to be guessed
    var currentWord = ""                    // word user is currently typing
    var tryIndex = 0                        // which try they are on
    var inPlay = false                      // if game has been set up
    var gameOver = false                    // when guess is correct or if no more guesses
    
    /// started if not first try or user has inputted letters
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    /// disable letter keys if game not set up or input is full length
    var disabledKeys: Bool {
        !inPlay || currentWord.count == 5
    }
    
    init() {
        newGame()
    }
    
    // MARK: - Setup
    
    /// Sets default values for guesses, keyColors, and currentWord. Selects random 5 letter word. Sets inPlay to true.
    func newGame() {
        populateDefaults()
        selectedWord = Global.commonWords.randomElement()!
        currentWord = ""
        inPlay = true
        tryIndex = 0
        gameOver = false
        print(selectedWord)
    }
    
    /// Set guesses and keyColors to default values
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
    
    /// Add letter to current guess when its associated key is pressed
    /// and update row
    /// - Parameter letter: the letter key pressed
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
        updateRow()
    }
    
    /// Enter key pressed
    func enterWord() {
        if currentWord == selectedWord {
            gameOver = true
            print("You Win!")
            setCurrentGuessColors()
            inPlay = false
        } else {
            if verifyWord() {
                print("valid word")
                setCurrentGuessColors()
                tryIndex += 1
                currentWord = ""
                if tryIndex == 6 {
                    gameOver = true
                    inPlay = false
                    print("You Lose")
                }
            } else {
                withAnimation {
                    self.incorrectAttempts[tryIndex] += 1
                }
                incorrectAttempts[tryIndex] = 0
            }
        }
    }
    
    /// Remove last letter from current guess when delete key pressed
    /// and update row
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    /// Update guess row with current guess input, put spaces at the end if input is not full 5 characters.
    /// Update current index of guesses with this word.
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    /// Verify that the word is in the device's built-in dictionary.
    /// Note: had to select dictionary for simulator: settings -> general -> dictionary
    /// - Returns: true if inputted word exists in the dictionary
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
    
    /// Set background colors for guess characters
    func setCurrentGuessColors() {
        // correct word as string array
        let correctLetters = selectedWord.map { String($0) }
        
        // frequency for each letter in correct word
        var freq = [String : Int]()
        for letter in correctLetters {
            freq[letter, default: 0] += 1
        }
        
        for i in 0..<correctLetters.count {
            let guessed = guesses[tryIndex].guessLetters[i]
            if guessed == correctLetters[i] {
                guesses[tryIndex].bgColors[i] = Color.correct
                freq[guessed]! -= 1
            } else if correctLetters.contains(guessed) && freq[guessed]! > 0 {
                guesses[tryIndex].bgColors[i] = Color.misplaced
                freq[guessed]! -= 1
            }
        }
        flipCards(for: tryIndex)
    }
    
    func flipCards(for row: Int) {
        for col in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {
                self.guesses[row].cardFlipped[col].toggle()
            }
        }
    }
}
