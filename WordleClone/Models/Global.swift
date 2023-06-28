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
}
