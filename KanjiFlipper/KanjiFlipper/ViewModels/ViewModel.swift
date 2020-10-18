//
//  ViewModel.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import Foundation
import Combine

protocol ViewModel: class {
    var viewTitle: CurrentValueSubject<String?, Never> { get }
}

extension ViewModel {
    var viewTitle: CurrentValueSubject<String?, Never> {
        CurrentValueSubject<String?, Never>(nil)
    }
}
