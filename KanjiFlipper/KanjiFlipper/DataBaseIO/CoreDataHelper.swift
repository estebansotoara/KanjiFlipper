//
//  CoreDataHelper.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/18/20.
//

import Foundation
import CoreData

protocol CoreDataHelper {
    associatedtype Model: NSFetchRequestResult
    static var tableName: String { get }

    var persistentContainer: NSPersistentCloudKitContainer { get }
    var context: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }

    init(container: NSPersistentCloudKitContainer)
}

extension CoreDataHelper {

    // MARK: - Read
    func findAll() throws -> [Model] {
        let request = NSFetchRequest<Model>(entityName: Self.tableName)
        do {
            let result = try backgroundContext.fetch(request)
            print("CoreDataHelper: findAll request: \(request) - result: \(result.count)")
            return result
        } catch {
            //TODO: throw db error
            print("fetchRequest: \(request) failed with error: \(error)")
            return []
        }
    }
}
