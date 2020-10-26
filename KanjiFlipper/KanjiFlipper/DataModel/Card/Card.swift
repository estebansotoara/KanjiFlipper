//
//  Card.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation

class Card: CardModel {

    // MARK: Properties
    var id: UUID
    var deckId: UUID
    var entryId: UUID
    var createdDate: Date
    var updatedDate: Date

    // MARK: Initializers
    init(id: UUID,
         deckId: UUID,
         entryId: UUID,
         created: Date,
         updated: Date) {

        self.id = id
        self.deckId = deckId
        self.entryId = entryId
        self.createdDate = created
        self.updatedDate = updated
    }

    init<T: CardModel>(model: T) {
        self.id = model.id
        self.deckId = model.deckId
        self.entryId = model.entryId
        self.createdDate = model.createdDate
        self.updatedDate = model.updatedDate
    }
}
