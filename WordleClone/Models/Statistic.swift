//
//  Statistic.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import Foundation

/// Keep track of user statistics
struct Statistic: Codable {
    
    var frequencies = [Int](repeating: 0, count: 6)     // times user won on each try
    var games = 0                                       // total games played
    var streak = 0                                      // current win streak
    var maxStreak = 0                                   // longest win streak
    
    // total wins: sum all values in frequencies
    var wins: Int {
        frequencies.reduce(0, +)
    }
    
    /// save stats to user defaults
    func saveStat() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Stat")
        }
    }
    
    /// load stats from user defaults
    static func loadStat() -> Statistic {
        if let savedStat = UserDefaults.standard.object(forKey: "Stat") as? Data {
            if let currentStat = try? JSONDecoder().decode(Statistic.self, from: savedStat) {
                return currentStat
            } else {
                return Statistic()
            }
        } else {
            return Statistic()
        }
    }
    
    /// update stats. index only passed in for win
    mutating func update(win: Bool, index: Int? = nil) {
        games += 1
        streak = win ? streak + 1 : 0
        if win {
            frequencies[index!] += 1
            maxStreak = max(maxStreak, streak)
        }
        saveStat()
    }
}
