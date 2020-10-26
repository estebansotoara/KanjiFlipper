//
//  CardModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation

protocol CardModel: Identifiable {

    // MARK: Properties
    var id: UUID { get set }
    var deckId: UUID { get set }
    var entryId: UUID { get set }
    var createdDate: Date { get set }
    var updatedDate: Date { get set }
}
