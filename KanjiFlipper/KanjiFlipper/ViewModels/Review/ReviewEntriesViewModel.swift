//
//  ReviewEntriesViewModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import Foundation
import Combine

enum ReviewEntriesSection {
    case deckInfo
}

enum ReviewEntriesSectionItem: CustomStringConvertible {
    case cardsOnDeck
    case dueCards
    case cardsReviewedToday

    var description: String {
        switch self {
        case .cardsOnDeck:
            return ReviewString.cardsOnDeck.localized
        case .dueCards:
            return ReviewString.due.localized
        case .cardsReviewedToday:
            return ReviewString.cardsReviewedToday.localized
        }
    }
}

typealias ReviewEntriesSectionModel =
    SectionModel<ReviewEntriesSection, ReviewEntriesSectionItem>

final class ReviewEntriesViewModel: ViewModel {

    // MARK: - Properties
    private var cancellableBag = Set<AnyCancellable>()

    //Title
    var viewTitle: CurrentValueSubject<String?, Never> {
        CurrentValueSubject(ReviewString.review.localized)
    }

    //Sections
    @Published private var sections: [ReviewEntriesSectionModel] = []
    var sectionsPublisher: Published<[ReviewEntriesSectionModel]>.Publisher {
        $sections
    }

    @Published private var cardsOnDeck: String = ""
    var cardsOnDeckPublisher: Published<String>.Publisher {
        $cardsOnDeck
    }

    @Published private var dueCards: String = ""
    var dueCardsPublisher: Published<String>.Publisher {
        $dueCards
    }

    @Published private var cardsReviewedToday: String = ""
    var cardsReviewedTodayPublisher: Published<String>.Publisher {
        $cardsReviewedToday
    }

    let startReviewSessionActionTitle = ReviewString
        .startReviewSession.localized

    // MARK: - Initializers
    init () {
        configureSections()
    }

    // MARK: - Configuration
    private func configureSections() {
        let deckInfoSection = ReviewEntriesSectionModel(
            model: .deckInfo,
            items: [.cardsOnDeck,
                    .dueCards,
                    .cardsReviewedToday])
        self.sections = [deckInfoSection]
    }

    // MARK: - Actions
    func startReviewSession() {
        //TODO
        print("ReviewEntriesViewModel: startReviewSession()")
    }
}
