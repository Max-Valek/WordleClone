//
//  UIWindow+Extension.swift
//  WordleClone
//
//  Created by Max Valek on 6/28/23.
//

import UIKit

/// for sharing screen. different for iphone and ipad so need this
extension UIWindow {
    
    static var key: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        return window
    }
}
