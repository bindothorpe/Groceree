//
//  UIDevice+Extensions.swift
//  Groceree
//
//  Created by Bindo Thorpe on 04/01/2025.
//

import UIKit

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
