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
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
