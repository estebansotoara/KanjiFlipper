//
//  ViewModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import Foundation

protocol ViewModel: class {
    var viewTitle: String { get }
}

extension ViewModel {
    var viewTitle: String? { nil }
}
