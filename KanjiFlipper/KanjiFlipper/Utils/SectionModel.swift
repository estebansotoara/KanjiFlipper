//
//  SectionModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/16/20.
//

import Foundation

struct SectionModel<Section, Item> {
    var model: Section
    var items: [Item]

    init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension SectionModel: Equatable where Section: Equatable,
                                        Item: Equatable {

    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.model == rhs.model
            && lhs.items == rhs.items
    }
}
