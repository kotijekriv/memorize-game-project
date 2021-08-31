//
//  ThemeEditView.swift
//  Memorize
//
//  Created by Pero Radich on 31.08.2021..
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: ThemeChooser.Theme
    
    var body: some View {
        Form{
            nameSection
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")){
            TextField("Name", text: $theme.name)
        }
    }
    
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor()
//    }
//}
