//
//  EntryCoreDataHelper.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/18/20.
//

import Foundation
import CoreData

class EntryCoreDataHelper: CoreDataHelper {
    typealias Model = EntryCDMO
    static var tableName: String { return "EntryCDMO" }

    // MARK: - Properties
    let persistentContainer: NSPersistentCloudKitContainer
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return persistentContainer.viewContext
    }()
    lazy var backgroundContext: NSManagedObjectContext = {
        let bkgContext = persistentContainer.newBackgroundContext()
        bkgContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return bkgContext
    }()

    // MARK: - Initializers
    required init(container: NSPersistentCloudKitContainer) {
        self.persistentContainer = container
    }

    convenience init() {
        self.init(container: DatabaseManager.shared.persistentContainer)
    }
}
