//
//  WordleCloneApp.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

@main
struct WordleCloneApp: App {
    
    @StateObject var dm = WordleDataModel()
    @StateObject var csManager = ColorSchemeManager()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dm)
                .environmentObject(csManager)
                .onAppear {
                    csManager.applyColorScheme()
                }
        }
    }
}
