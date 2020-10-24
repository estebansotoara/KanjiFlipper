//
//  Entry.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/10/20.
//

import Foundation

class Entry: EntryModel, Decodable {

    // MARK: Enums
    enum CodingKeys: String, CodingKey {
        case id
        case character
        case characterType = "character_type"
        case keyword
        case hint
        case numberOfStrokes = "number_of_strokes"
        case rtkNumber = "rtk_number"
        case rtkChapter = "rtk_chapter"
    }

    enum CharacterType: String, Decodable {
        case kanji
        case primitive
    }

    // MARK: Properties
    var id: UUID
    var character: String
    var characterType: CharacterType
    var keyword: String
    var hint: String?
    var numberOfStrokes: String
    var rtkNumber: String
    var rtkChapter: String

    // MARK: Initializers
    required init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: CodingKeys.self)

        self.id = try container
            .decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.character = try container
            .decode(String.self, forKey: .character)
        self.characterType = try container
            .decode(CharacterType.self, forKey: .characterType)
        self.keyword = try container
            .decode(String.self, forKey: .keyword)
        self.hint = try container
            .decodeIfPresent(String.self, forKey: .hint)
        self.numberOfStrokes = try container
            .decode(String.self, forKey: .numberOfStrokes)
        self.rtkNumber = try container
            .decode(String.self, forKey: .rtkNumber)
        self.rtkChapter = try container
            .decode(String.self, forKey: .rtkChapter)
    }

    init<T: EntryModel>(model: T) {
        self.id = model.id
        self.character = model.character
        self.characterType = model.characterType
        self.keyword = model.keyword
        self.hint = model.hint
        self.numberOfStrokes = model.numberOfStrokes
        self.rtkNumber = model.rtkNumber
        self.rtkChapter = model.rtkChapter
    }
}

extension Entry: Comparable {
    static func < (lhs: Entry, rhs: Entry) -> Bool {
        Int(lhs.rtkNumber) ?? 0 < Int(rhs.rtkNumber) ?? 0
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        lhs.id < rhs.id
    }
}

extension Entry: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(character)
        hasher.combine(characterType)
        hasher.combine(keyword)
    }
}
