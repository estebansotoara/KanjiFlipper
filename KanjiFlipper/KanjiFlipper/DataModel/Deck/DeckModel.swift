//
//  DeckModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation

protocol DeckModel: Identifiable {

    // MARK: Properties
    var id: UUID { get set }
    var name: String { get set }
    var createdDate: Date { get set }
    var updatedDate: Date { get set }
}
