//
//  SettingsViewModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/16/20.
//

import Foundation
import Combine

enum SettingsSection {
    case dataBase
}

enum SettingsSectionItem: CustomStringConvertible {
    case resetDataBase

    var description: String {
        switch self {
        case .resetDataBase:
            return SettingsString.resetDataBase.localized
        }
    }
}

typealias SettingsSectionModel =
    SectionModel<SettingsSection, SettingsSectionItem>

final class SettingsViewModel: ViewModel {

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()

    //Title
    var viewTitle: CurrentValueSubject<String?, Never> {
        CurrentValueSubject(SettingsString.settings.localized)
    }

    //Sections
    @Published private var sections: [SettingsSectionModel] = []
    var sectionsPublisher: Published<[SettingsSectionModel]>.Publisher {
        $sections
    }

    // MARK: - Initializers
    init () {
        configureSections()
    }

    // MARK: - Configuration
    private func configureSections() {
        let dataBaseSection = SettingsSectionModel(model: .dataBase,
                                                   items: [.resetDataBase])
        self.sections = [dataBaseSection]
    }

    // MARK: - Actions
    func resetDataBase() {
        try? DatabaseManager.shared.resetDataBase()
    }
}
