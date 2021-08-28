//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Pero Radich on 27.08.2021..
//

import SwiftUI

class ThemeChooserStore: ObservableObject {
    let name: String
    
    @Published var themes = [ThemeChooser.Theme](){
        didSet{
            storeInUserDefaults()
        }
    }
    
    
    private var userDefaultsKey: String {
        "ThemeStore: " + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<ThemeChooser.Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        
        if themes.isEmpty {
            print("using built-in themes")
            insertTheme(named: "Transport", emojis: ["🚗", "🚕", "🏎", "🚑", "🚜", "✈️", "🛸", "🚀"], color: .yellow)
            insertTheme(named: "Nature", emojis: ["🐶", "🐢", "🦑", "🐬", "🐛", "🦄", "🦅", "🐧", "🦆", "🐥"], color: .green)
            insertTheme(named: "Tech", emojis: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "💾", "💿", "📷"], color: .gray)
            insertTheme(named: "Faces", emojis: ["😀", "🥳", "🥸", "😍", "😇", "🤗", "😡", "🤯", "😈", "🤡", "🥶"], color: .pink)
            insertTheme(named: "Tools", emojis: ["🪛", "🔧", "🔨", "🛠", "⛏", "🪚", "🔩", "🧲", "🪤"], color: .purple)
            insertTheme(named: "Weapons", emojis: ["🔫", "💣", "🧨", "🪓", "🔪", "🗡", "⚔️", "🛡", "🚬", "⚰️", "🔮", "⚱️"], color: .orange)
        } else {
            print("successfully loaded themes from UserDefaults: \(themes)")
            print(RGBAColor(color: .red))
        }
        
    }
    
    
    // MARK: -Intent
    
    func insertTheme(named name: String, emojis: [String]? = nil, color: Color, at index: Int = 0){
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let chosenColor = RGBAColor(color: color)
        let theme = ThemeChooser.Theme(name: name, emojis: emojis ?? [""], color: chosenColor, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
