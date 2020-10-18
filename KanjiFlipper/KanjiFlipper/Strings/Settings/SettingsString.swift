//
//  SettingsString.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/17/20.
//

import Foundation

enum SettingsString: String {

    case settings = "Settings"
    case resetDataBase = "Reset data base"
}

extension SettingsString: Localizable {
    var key: String { return rawValue }
    var tableName: String { return "Settings" }
}
