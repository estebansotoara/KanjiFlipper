//
//  SRSEntry.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation

class SRSEntry: SRSEntryModel {

    private static let minEasinessFactor: Double = 1.3
    private static let defaultEasinessFactor: Double = 2.5

    // MARK: Properties
    var id: UUID
    var cardId: UUID
    var repetition: Int
    var interval: Int
    var easinessFactor: Double
    var nextDueDate: Date
    var createdDate: Date
    var updatedDate: Date

    // MARK: Initializers
    init(id: UUID,
         cardId: UUID,
         repetition: Int,
         interval: Int,
         easinessFactor: Double,
         nextDueDate: Date,
         createdDate: Date,
         updatedDate: Date) {

        self.id = id
        self.cardId = cardId
        self.repetition = repetition
        self.interval = interval
        self.easinessFactor = easinessFactor
        self.nextDueDate = nextDueDate
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }

    init(cardId: UUID) {

        self.id = UUID()
        self.cardId = cardId
        self.repetition = 0
        self.interval = 0
        self.easinessFactor = Self.defaultEasinessFactor
        self.nextDueDate = Date()
        self.createdDate = Date()
        self.updatedDate = Date()
    }

    init<T: SRSEntryModel>(model: T) {
        self.id = model.id
        self.cardId = model.cardId
        self.repetition = model.repetition
        self.interval = model.interval
        self.easinessFactor = model.easinessFactor
        self.nextDueDate = model.nextDueDate
        self.createdDate = model.createdDate
        self.updatedDate = model.updatedDate
    }
}
