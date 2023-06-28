//
//  Color+Extension.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

extension Color {
    // Colors from assets
    static var wrong: Color { Color(UIColor(named: "wrong")!) }
    static var misplaced: Color { Color(UIColor(named: "misplaced")!) }
    static var correct: Color { Color(UIColor(named: "correct")!) }
    static var unused: Color { Color(UIColor(named: "unused")!) }
    static var systemBackground: Color { Color(.systemBackground) }
}
