//
//  String + Extension.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 12.07.2024.
//

import Foundation

extension String {
    func toCamelCase() -> String {
        let words = self.split(separator: " ")
        
        let camelCaseWords = words.enumerated().map { (index, word) -> String in
            return index == 0 ? word.lowercased() : word.capitalized
        }
        
        return camelCaseWords.joined()
    }
}
