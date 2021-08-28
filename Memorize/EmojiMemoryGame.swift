//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pero Radich on 09.07.2021..
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private var themes: Array<Theme>
    private static var chosenTheme: Theme?
    
    private struct Theme {
        var name: String
        var emojis: [String]
        var numberOfPairsOfCards: Int
        var color: Color
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        //unsafe unwrapping LOL xD
        if chosenTheme!.emojis.count < chosenTheme!.numberOfPairsOfCards{
            chosenTheme!.numberOfPairsOfCards = chosenTheme!.emojis.count
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: chosenTheme!.numberOfPairsOfCards) { pairIndex in
            chosenTheme!.emojis[pairIndex]
        }
    }
        
    init() {
        themes = Array<Theme>()
        
        themes.append(Theme(name: "Transport",
                            emojis: ["🚗", "🚕", "🏎", "🚑", "🚜", "✈️", "🛸", "🚀"],
                            numberOfPairsOfCards: 4,
                            color: .yellow))
        themes.append(Theme(name: "Faces",
                            emojis: ["😀", "🥳", "🥸", "😍", "😇", "🤗", "😡", "🤯", "😈", "🤡", "🥶"],
                            numberOfPairsOfCards: 5,
                            color: .pink))
        themes.append(Theme(name: "Nature",
                            emojis: ["🐶", "🐢", "🦑", "🐬", "🐛", "🦄", "🦅", "🐧", "🦆", "🐥"],
                            numberOfPairsOfCards: 6,
                            color: .green))
        themes.append(Theme(name: "Tech",
                            emojis: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "💾", "💿", "📷"],
                            numberOfPairsOfCards: 6,
                            color: .gray))
        themes.append(Theme(name: "Tools",
                            emojis: ["🪛", "🔧", "🔨", "🛠", "⛏", "🪚", "🔩", "🧲", "🪤"],
                            numberOfPairsOfCards: 6,
                            color: .purple))
        themes.append(Theme(name: "Weapons",
                            emojis: ["🔫", "💣", "🧨", "🪓", "🔪", "🗡", "⚔️", "🛡", "🚬", "⚰️", "🔮", "⚱️"],
                            numberOfPairsOfCards: 6,
                            color: .orange))
        
        newGame()
    }
    
    
    @Published private var model: MemoryGame<String>?
    
    var cards: Array<MemoryGame<String>.Card>{
        return model!.cards
    }
    
    var score: Int{
        return model!.score
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
            return EmojiMemoryGame.chosenTheme!.color
        }
    }
    
    // MARK: - Intents(s)
    
    func choose(_ card:MemoryGame<String>.Card) {
        model!.choose(card)
    }
    
    func newGame() {
        if themes.randomElement() == nil{
            EmojiMemoryGame.chosenTheme = Theme(name: "Error", emojis: ["😡", "🤯", "😈"], numberOfPairsOfCards: 3, color: .accentColor)
        } else {
            EmojiMemoryGame.chosenTheme = themes.randomElement()!
        }
        
        EmojiMemoryGame.chosenTheme?.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}

