//
//  IconAsset.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/17/20.
//

import Foundation

enum IconAsset: String {

    case textBookClosed = "text.book.closed"
    case textBookClosedFill = "text.book.closed.fill"
    case gearshape = "gearshape"
    case gearshapeFill = "gearshape.fill"
}

extension IconAsset: Asset {
    var imageName: String { rawValue }
}
