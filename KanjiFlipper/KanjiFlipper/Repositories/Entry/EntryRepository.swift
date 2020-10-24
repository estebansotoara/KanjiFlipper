//
//  EntryRepository.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/17/20.
//

import Foundation
import Combine

class EntryRepository: Repository<Entry> {

    override var refreshSource: AnyPublisher<[Entry], Error> {
        return loadDataFromDB().eraseToAnyPublisher()
    }

    // MARK: - Initializers
    override init() {
        super.init()
    }

    // MARK: - Data Load
    private func loadDataFromDB() -> Future<[Entry], Error> {
        print("EntryRepository will loadDataFromDB()")

        return Future<[Entry], Error> { promise in
            let entryCDH = EntryCoreDataHelper()
            do {
                let entryMOs = try entryCDH.findAll()
                let entries: [Entry] = entryMOs.map({ Entry(model: $0) })
                print("EntryRepository loadDataFromDB: success: entry count \(entries.count)")
                promise(.success(entries))
            } catch {
                print("EntryRepository loadDataFromDB: failed with error: \(error)")
                promise(.failure(error))
            }
        }
    }
}
