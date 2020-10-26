//
//  SRSEntryCDMO.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/25/20.
//

import Foundation
import CoreData

@objc(SRSEntryCDMO)
class SRSEntryCDMO: NSManagedObject, SRSEntryModel {
    
    // MARK: Properties
    @NSManaged private var idStringValue: String
    @NSManaged private var cardIdStringValue: String
    @NSManaged var repetition: Int
    @NSManaged var interval: Int
    @NSManaged var easinessFactor: Double
    @NSManaged var nextDueDate: Date
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
    var cardId: UUID {
        get {
            return UUID(uuidString: cardIdStringValue) ?? UUID()
        }
        set {
            cardIdStringValue = newValue.uuidString
        }
    }
    
    // MARK: Initializers
    convenience init<T: SRSEntryModel>(model: T, context: NSManagedObjectContext) {
        self.init(context: context)
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
