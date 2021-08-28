//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Pero Radich on 25.06.2021..
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeChooserStore(named: "Default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooserView().environmentObject(themeStore)
//            EmojiMemoryGameView(viewModel: game)
        }
    }
}
