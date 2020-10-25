//
//  BorderedButton.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit

class BorderedButton: UIButton, Bordered {
    var radiusMultiplier: CGFloat = defaultRadiusMultiplier {
        didSet {
            updateCorderRadius()
        }
    }
    var borderWidth: CGFloat = defaultBorderWidth {
        didSet {
            updateBorderWidth()
        }
    }
    var borderColor: UIColor? {
        didSet {
            updateBoderColor()
        }
    }
    override var bounds: CGRect {
        didSet {
            updateCorderRadius()
        }
    }
}
