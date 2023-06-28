//
//  Global.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

// for using UIString
import UIKit

// store global computed properties
enum Global {
    
    // width of device
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    // height of device
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }
    
    // for landscape/portrait mode
    static var minDimension: CGFloat {
        min(screenWidth, screenHeight)
    }
    
    // max board width depending on device
    static var boardWidth: CGFloat {
        switch minDimension {
        // up to and including ipod touch
        case 0...320:
            return screenWidth - 55
        // iphones
        case 321...430:
            return screenWidth - 50
        // smaller ipads
        case 431...1000:
            return 350
        // anything larger
        default:
            return 500
        }
    }
    
    // scale keyboard based on device (all based on iphone design)
    static var keyboardScale: CGFloat {
        switch minDimension {
        // up to width of largest iPhone (in portrait mode)
        case 0...430:
            // screen width / width of iphone 13 pro
            return screenWidth / 390
        // mid sized ipad
        case 431...1000:
            return CGFloat(1.2)
        // large ipad
        default:
            return CGFloat(1.6)
        }
    }
}
