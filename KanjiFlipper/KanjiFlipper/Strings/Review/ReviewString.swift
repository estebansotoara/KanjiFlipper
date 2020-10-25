//
//  ReviewString.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/24/20.
//

import Foundation

enum ReviewString: String {

    case review = "Review"
    case cardsOnDeck = "Cards on deck"
    case due = "Due"
    case cardsReviewedToday = "Cards reviewed today"
    case startReviewSession = "Start review session"
}

extension ReviewString: Localizable {
    var key: String { return rawValue }
    var tableName: String { return "Review" }
}
