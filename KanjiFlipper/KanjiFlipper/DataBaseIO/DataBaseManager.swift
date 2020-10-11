//
//  DataBaseManager.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/10/20.
//

import Foundation
import CoreData

class DatabaseManager {

    // MARK: Properties
    static let shared = DatabaseManager(containerName: "KanjiFlipper")

    let persistentContainer: NSPersistentCloudKitContainer
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    lazy var backgroundContext: NSManagedObjectContext = {
        persistentContainer.newBackgroundContext()
    }()
    private let defaultEntriesFileName = "rtk_entries.json"

    // MARK: Initializers
    init(containerName: String) {

        let container = NSPersistentCloudKitContainer(name: containerName)
        container.loadPersistentStores(
            completionHandler: { (storeDescription, error) in
                print("DatabaseManager: loadPersistentStores: storeDescription: \(storeDescription)")
                if let error = error {
                    assertionFailure("DatabaseManager: loadPersistentStores failed with error \(error)")
                }
            })
        self.persistentContainer = container
    }

    // MARK: - Utils
    func initializeDataBaseIfNeeded() {
        /*
         Check if the default entries are loaded, otherwise read them
         from the local file and store them
         */
        let fetchRequest: NSFetchRequest<EntryCDMO> = EntryCDMO.fetchRequest()
        do {
            let count = try backgroundContext.count(for: fetchRequest)
            print("initializeDataBaseIfNeeded: entry count: \(count)")
            if count <= 0 {
                initializeDataBase()
            }
        } catch {
            print("fetchRequest: \(fetchRequest) failed with error: \(error)")
            try? deleteAllInfo()
            initializeDataBase()
        }
    }

    func initializeDataBase() {
        let entries = Bundle.main.decode([Entry].self,
                                         from: defaultEntriesFileName)
        _ = entries.map({
            EntryCDMO(entry: $0, context: backgroundContext)
        })
        saveContext(backgroundContext)
    }

    func migrateIfNeeded() throws {
        //TODO
    }

    func deleteAllInfo() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = EntryCDMO.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try backgroundContext.execute(deleteRequest)
            print("deleteAllInfo success")
        } catch {
            print("deleteAllInfo: \(deleteRequest) failed with error: \(error)")
        }
    }

    private func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
                print("saveContext success")
            } catch {
                print("saveContext: \(context) failed with error: \(error)")
            }
        } else {
            print("saveContext hasChanges == false")
        }
    }

    func savePendingChanges() {
        saveContext(context)
        saveContext(backgroundContext)
    }
}
