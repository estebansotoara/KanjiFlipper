//
//  CardCDMO.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation
import CoreData

@objc(CardCDMO)
class CardCDMO: NSManagedObject, CardModel {
    
    // MARK: Properties
    @NSManaged private var idStringValue: String
    @NSManaged private var deckIdStringValue: String
    @NSManaged private var entryIdStringValue: String
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
    var deckId: UUID {
        get {
            return UUID(uuidString: deckIdStringValue) ?? UUID()
        }
        set {
            deckIdStringValue = newValue.uuidString
        }
    }
    var entryId: UUID {
        get {
            return UUID(uuidString: entryIdStringValue) ?? UUID()
        }
        set {
            entryIdStringValue = newValue.uuidString
        }
    }
    
    // MARK: Initializers
    convenience init<T: CardModel>(model: T, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = model.id
        self.deckId = model.deckId
        self.entryId = model.entryId
        self.createdDate = model.createdDate
        self.updatedDate = model.updatedDate
    }
}
