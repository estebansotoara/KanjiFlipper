//
//  DeckCDMO.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation
import CoreData

@objc(DeckCDMO)
class DeckCDMO: NSManagedObject, DeckModel {

    // MARK: Properties
    @NSManaged private var idStringValue: String
    @NSManaged var name: String
    @NSManaged var createdDate: Date
    @NSManaged var updatedDate: Date

    /*
     Core Data is dumb
     */
    var id: UUID {
        get {
            return UUID(uuidString: idStringValue) ?? UUID()
        }
        set {
            idStringValue = newValue.uuidString
        }
    }

    // MARK: Initializers
    convenience init<T: DeckModel>(model: T, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = model.id
        self.name = model.name
        self.createdDate = model.createdDate
        self.updatedDate = model.updatedDate
    }
}
