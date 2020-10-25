//
//  StudyString.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/17/20.
//

import Foundation

enum StudyString: String {

    case study = "Study"
    case lesson = "Lesson"
    case entryNumber = "Entry number"
    case numberOfStrokes = "Number of strokes"
}

extension StudyString: Localizable {
    var key: String { return rawValue }
    var tableName: String { return "Study" }
}
