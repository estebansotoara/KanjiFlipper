//
//  Localizable.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import Foundation

protocol Localizable {
    var key: String { get }
    var tableName: String { get }
}

extension Localizable {
    var localized: String {
        return NSLocalizedString(key,
                                 tableName: tableName,
                                 comment: "")
    }
}
