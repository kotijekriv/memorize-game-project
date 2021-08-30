//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pero Radich on 09.07.2021..
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String>
    
    private static var chosenTheme: ThemeChooser.Theme?
    
    static func createMemoryGame() -> MemoryGame<String> {
        //unsafe unwrapping LOL xD
        if chosenTheme!.emojis.count < chosenTheme!.numberOfPairsOfCards{
            chosenTheme!.numberOfPairsOfCards = chosenTheme!.emojis.count
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: chosenTheme!.numberOfPairsOfCards) { pairIndex in
            chosenTheme!.emojis[pairIndex]
        }
    }
        
    init(theme: ThemeChooser.Theme) {
        EmojiMemoryGame.chosenTheme = theme
        EmojiMemoryGame.chosenTheme?.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    var score: Int{
        return model.score
    }
    
    var themeName: String {
        if EmojiMemoryGame.chosenTheme?.name == nil {
            return "Error no name"
        }else {
            return EmojiMemoryGame.chosenTheme!.name
        }
    }
    
    var themeColor: Color {
        if EmojiMemoryGame.chosenTheme?.color == nil {
            return .accentColor
        }else {
            return Color(rgbaColor: EmojiMemoryGame.chosenTheme!.color)
        }
    }
    
    // MARK: - Intents(s)
    
    func choose(_ card:MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
    }
    
}

