//
//  TextfieldView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/12/24.
//

import SwiftUI

struct TextfieldView: View {
    @StateObject var vm: CountriesViewModel
    @FocusState var isFocused
    var body: some View {
        #if os(iOS) && !targetEnvironment(macCatalyst)
        TextField("Name the country", text: $vm.userGuessesText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .focused($isFocused)
            .padding()
            .onAppear {
                isFocused = true
            }
        #endif
        
        #if targetEnvironment(macCatalyst)
        TextField("Name the country", text: $vm.userGuessesText)
            .autocorrectionDisabled()
            .focused($isFocused)
            .padding()
            .onAppear {
                isFocused = true
            }
        #endif
        
    }
}

//#Preview {
//    TextfieldView()
//}
