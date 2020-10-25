//
//  StudyEntryDetailsViewModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import Foundation
import Combine

final class StudyEntryDetailsViewModel: ViewModel {

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let repository: EntryRepository

    @Published private var entry: Entry

    @Published private var character: String = ""
    var characterPublisher: Published<String>.Publisher {
        $character
    }

    @Published private var keyword: String = ""
    var keywordPublisher: Published<String>.Publisher {
        $keyword
    }

    @Published private var rtkNumber: String = ""
    var rtkNumberPublisher: Published<String>.Publisher {
        $rtkNumber
    }

    @Published private var numberOfStrokes: String = ""
    var numberOfStrokesPublisher: Published<String>.Publisher {
        $numberOfStrokes
    }
    /*
    @Published private var hint: String? = nil
    var hintPublisher: Published<String?>.Publisher {
        $hint
    }
    */

    let rtkNumberTitle = StudyString.entryNumber.localized
    let numberOfStrokesTitle = StudyString.numberOfStrokes.localized

    // MARK: - Initializers
    init(entry: Entry,
         repository: EntryRepository) {
        self.entry = entry
        self.repository = repository
        configureRepository()
        configurePublishers()
    }

    // MARK: - Configuration
    private func configurePublishers() {

        $entry
            .sink(receiveValue: { [weak self] (entry) in
                print("StudyEntryDetailsViewModel: entry sink: \(entry)")

                self?.character = entry.character
                self?.keyword = entry.keyword
                self?.rtkNumber = entry.rtkNumber
                self?.numberOfStrokes = entry.numberOfStrokes
                //self?.hint = entry.hint
            })
            .store(in: &cancellableBag)
    }

    private func configureRepository() {
        let entryId = entry.id

        repository.dataPublisher
            .sink(receiveValue: { [weak self] (data) in
                print("StudyEntryDetailsViewModel: repository dataPublisher sink: \(data.count)")
                guard let entry = data
                        .first(where: { $0.id == entryId }) else {
                    return
                }
                self?.entry = entry
            })
            .store(in: &cancellableBag)
    }
}
