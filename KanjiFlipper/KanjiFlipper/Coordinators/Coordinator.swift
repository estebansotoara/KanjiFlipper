//
//  Coordinator.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/4/20.
//

import UIKit

protocol Coordinator: class {
    var rootViewController: UIViewController { get }

    func start()
}

extension Coordinator {
    static var typeName: String { return String(describing: self) }
    var typeName: String { return Self.typeName }
}

enum NavigationType {
    case show
    case present
}
