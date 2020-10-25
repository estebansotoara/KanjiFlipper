//
//  StudyEntryListViewModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/17/20.
//

import Foundation
import Combine

protocol StudyEntryListViewModelDelegate: class {
    func studyEntryListViewModel(
        _ viewModel: StudyEntryListViewModel,
        showDetails detailsViewModel: StudyEntryDetailsViewModel)
}

struct StudyEntryListSection: Hashable {
    let lessonNumber: Int
    let entryCount: Int
}

struct StudyEntryListItem: Hashable, Identifiable {
    var id: UUID
    let entry: Entry

    init(entry: Entry) {
        self.id = entry.id
        self.entry = entry
    }
}

typealias StudyEntryListSectionModel =
    SectionModel<StudyEntryListSection, StudyEntryListItem>

final class StudyEntryListViewModel: ViewModel {

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()
    private let repository = EntryRepository()

    private weak var delegate: StudyEntryListViewModelDelegate?

    //Title
    var viewTitle: CurrentValueSubject<String?, Never> {
        CurrentValueSubject(StudyString.study.localized)
    }

    //Sections
    @Published private var sections: [StudyEntryListSectionModel] = []
    var sectionsPublisher: Published<[StudyEntryListSectionModel]>.Publisher {
        $sections
    }

    // MARK: - Initializers
    init () {
        configureSections()
        configureRepository()

        repository.fetchData()
    }

    // MARK: - Configuration
    private func configureSections() {
        print("StudyEntryListViewModel: configureSections")
    }

    private func configureRepository() {
        print("StudyEntryListViewModel: configureSections")
        repository.dataPublisher
            .sink(receiveValue: { [weak self] (data) in
                print("StudyEntryListViewModel: repository dataPublisher sink: \(data.count)")
                let dataDict = Dictionary(grouping: data,
                                           by: { $0.rtkChapter })
                let sortedKeys = dataDict.keys.sorted()

                var sections = [StudyEntryListSectionModel]()
                for key in sortedKeys {
                    guard let lessonNumber = Int(key) else { continue }
                    let items = dataDict[key] ?? []
                    let sectionModel = StudyEntryListSection(
                        lessonNumber: lessonNumber,
                        entryCount: items.count)
                    let sectionItems = items.sorted().map({
                        StudyEntryListItem(entry: $0)
                    })
                    sections.append(StudyEntryListSectionModel(
                                        model: sectionModel,
                                        items: sectionItems))
                }
                self?.sections = sections
            })
            .store(in: &cancellableBag)
    }

    // MARK: - Utils
    func set(delegate: StudyEntryListViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Actions
    func selectItem(_ entry: StudyEntryListItem) {
        print("StudyEntryListViewModel: selectItem: \(entry)")

        let viewModel = StudyEntryDetailsViewModel(entry: entry.entry,
                                                   repository: repository)
        delegate?.studyEntryListViewModel(self, showDetails: viewModel)
    }
}
