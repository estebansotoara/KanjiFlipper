//
//  Bordered.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit

protocol Bordered {
    var radiusMultiplier: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor? { get set }
}

extension Bordered where Self: UIView {

    // Default values
    static var defaultRadiusMultiplier: CGFloat {
        return 0
    }

    static var defaultBorderWidth: CGFloat {
        return 0
    }

    // Helper functions for updating the layer
    func updateBorderWidth() {
        layer.borderWidth = borderWidth
    }

    func updateBoderColor() {
        layer.borderColor = borderColor?.cgColor
    }

    func updateCorderRadius() {
        guard radiusMultiplier != 0 else {
            layer.cornerRadius = 0
            return
        }
        let shortestDimmension = min(bounds.size.width, bounds.size.height)
        layer.cornerRadius = shortestDimmension / radiusMultiplier
    }
}
