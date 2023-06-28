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
    
    // no index passed if didnt win
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
