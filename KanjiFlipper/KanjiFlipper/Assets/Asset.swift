//
//  Asset.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import UIKit

protocol Asset {
    var imageName: String { get }
    var image: UIImage? { get }
    var templateImage: UIImage? { get }
}

extension Asset {
    var image: UIImage? {
        return UIImage(asset: self)
    }

    var templateImage: UIImage? {
        return image?.withRenderingMode(.alwaysTemplate)
    }
}

extension UIImage {
    convenience init?(asset: Asset) {
        #if DEV
        if let _ = UIImage(named: asset.imageName) {
            self.init(named: asset.imageName)
        } else {
            assertionFailure("Cannot find image with name: \(asset.imageName)")
            return nil
        }
        #else
        self.init(named: asset.imageName)
        #endif
    }
}
