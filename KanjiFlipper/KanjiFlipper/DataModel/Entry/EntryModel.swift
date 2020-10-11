//
//  EntryModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/11/20.
//

import Foundation

protocol EntryModel: Identifiable {

    // MARK: Properties
    var id: UUID { get set }
    var character: String { get set }
    var characterType: Entry.CharacterType { get set }
    var keyword: String { get set }
    var hint: String? { get set }
    var numberOfStrokes: String { get set }
    var rtkNumber: String { get set }
    var rtkChapter: String { get set }
}
