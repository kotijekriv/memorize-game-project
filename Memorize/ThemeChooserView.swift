//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Pero Radich on 28.08.2021..
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var store: ThemeChooserStore
//
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView{
            List{
                ForEach(store.themes){ theme in
                    //TODO NAPRAVITI DESTINACIJU
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: store.themes[theme]))){
                        VStack (alignment: .leading) {
                            Text(theme.name)
                                .font(.headline)
                                .foregroundColor(Color(rgbaColor: theme.color))
                            HStack {
                                Text("\(String(theme.numberOfPairsOfCards)) pairs")
                                Text(emojiPreview(theme.emojis))
                            }
                        }
                        .gesture(editMode == .active ? editTap(theme): nil)
                    }
                    
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Memorize")
            .toolbar{
                ToolbarItem{ EditButton() }
                ToolbarItem{}
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    func editTap(_ theme: ThemeChooser.Theme) -> some Gesture {
        TapGesture().onEnded {
//            ThemeEditor(theme: $store.themes[theme])
        }
    }
    
    func emojiPreview(_ emojis: [String]) -> String {
        if emojis.count > 2 {
            return emojis[0] + emojis[1] + emojis[2]
        } else if emojis.count > 1 {
            return emojis[0] + emojis[1]
        } else {
            return "??"
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
            .environmentObject(ThemeChooserStore(named: "Preview"))
    }
}
