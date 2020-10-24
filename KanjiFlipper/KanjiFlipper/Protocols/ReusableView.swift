//
//  ReusableView.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
