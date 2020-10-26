//
//  Deck.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation

class Deck: DeckModel {

    // MARK: Properties
    var id: UUID
    var name: String
    var createdDate: Date
    var updatedDate: Date

    // MARK: Initializers
    init(id: UUID,
         name: String,
         created: Date,
         updated: Date) {

        self.id = id
        self.name = name
        self.createdDate = created
        self.updatedDate = updated
    }

    init<T: DeckModel>(model: T) {
        self.id = model.id
        self.name = model.name
        self.createdDate = model.createdDate
        self.updatedDate = model.updatedDate
    }
}

// MARK: Factory
extension Deck {
    static func makeDefaultDeck() -> Deck {
        Deck(id: UUID(),
             name: "Default deck",
             created: Date(),
             updated: Date())
    }
}
