//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Pero Radich on 28.08.2021..
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var store: ThemeChooserStore
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView{
            List{
                ForEach(store.themes){ theme in
                    //TODO NAPRAVITI DESTINACIJU
                    NavigationLink(destination: Text(theme.name)){
                        VStack (alignment: .leading) {
                            Text(theme.name)
                                .font(.headline)
                            HStack {
                                Text("\(String(theme.emojis.count)) cards")
                                Text(theme.emojis[0] + theme.emojis[1])
                              //TODO NAPRAVITI BOJE
                                Color(rgbaColor: theme.color)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Memorize")
        }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
            .environmentObject(ThemeChooserStore(named: "Preview"))
    }
}
