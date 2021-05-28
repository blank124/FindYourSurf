//
//  Colors.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/20/21.
//

import Foundation
import UIKit

enum CustomColor: String {
    case surfBlue = "SurfBlue"
    case surfYellow = "SurfYellow"
}

extension UIColor {
    static func customColor(_ color: CustomColor) -> UIColor {
        return UIColor(named: color.rawValue)!
    }
}
