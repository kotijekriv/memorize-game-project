//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Pero Radich on 27.08.2021..
//

import Foundation

struct ThemeChooser: Codable{
    struct Theme: Identifiable, Codable, Hashable {
        var name: String
        var emojis: [String]
        var numberOfPairsOfCards: Int
        var color: RGBAColor
        var id: Int
    }
    
}
