//
//  Bundle+Decode.swift
//  KanjiFlipper
//
//  Created by AraDev on 10/9/20.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in app bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in app bundle.")
        }

        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from app bundle.")
        }

        return decodedData
    }
}
