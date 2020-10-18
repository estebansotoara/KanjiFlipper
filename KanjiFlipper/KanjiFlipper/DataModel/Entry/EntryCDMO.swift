//
//  EntryCDMO.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/11/20.
//

import Foundation
import CoreData

@objc(EntryCDMO)
class EntryCDMO: NSManagedObject, EntryModel {

    // MARK: Properties
    @NSManaged var idStringValue: String
    @NSManaged var character: String
    @NSManaged private var characterTypeValue: String
    @NSManaged var keyword: String
    @NSManaged var hint: String?
    @NSManaged var numberOfStrokes: String
    @NSManaged var rtkNumber: String
    @NSManaged var rtkChapter: String

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
    var characterType: Entry.CharacterType {
        get {
            return Entry.CharacterType(
                rawValue: self.characterTypeValue) ?? .kanji
        }
        set {
            characterTypeValue = newValue.rawValue
        }
    }

    // MARK: Initializers
    convenience init<T: EntryModel>(entry: T, context: NSManagedObjectContext) {
        self.init(context: context)
        id = entry.id
        character = entry.character
        characterType = entry.characterType
        keyword = entry.keyword
        hint = entry.hint
        numberOfStrokes = entry.numberOfStrokes
        rtkNumber = entry.rtkNumber
        rtkChapter = entry.rtkChapter
    }

    // MARK: - Utils
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntryCDMO> {
        return NSFetchRequest<EntryCDMO>(entityName: "EntryCDMO")
    }
}