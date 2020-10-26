//
//  SRSEntryModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation

protocol SRSEntryModel: Identifiable {

    // MARK: Properties
    var id: UUID { get set }
    var cardId: UUID { get set }
    var repetition: Int { get set }
    var interval: Int { get set }
    var easinessFactor: Double { get set }
    var nextDueDate: Date { get set }
    var createdDate: Date { get set }
    var updatedDate: Date { get set }
}
