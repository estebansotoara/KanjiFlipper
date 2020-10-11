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
}
