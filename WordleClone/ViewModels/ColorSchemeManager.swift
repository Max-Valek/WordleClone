//
//  ColorSchemeManager.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import SwiftUI

enum ColorScheme: Int {
    case unspecified, light, dark
}

class ColorSchemeManager: ObservableObject {
    
    @AppStorage("colorScheme") var colorScheme: ColorScheme = .unspecified {
        didSet {
            applyColorScheme()
        }
    }
    
    func applyColorScheme() {
        UIWindow.key?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: colorScheme.rawValue)!
    }
}
