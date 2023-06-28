//
//  Statistic.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import Foundation

struct Statistic: Codable {
    // frequency of times we were successful on a certain try
    var frequencies = [Int](repeating: 0, count: 6)
    // number of games played
    var games = 0
    // streak
    var streak = 0
    // longest streak
    var maxStreak = 0
    
    var wins: Int {
        frequencies.reduce(0, +)
    }
    
    func saveStat() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Stat")
        }
    }
    
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
    
    
}
