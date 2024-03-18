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
        TextField("Name the country", text: $vm.userGuessesText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .focused($isFocused)
            .padding()
            .onAppear {
                isFocused = true
            }
    }
}

//#Preview {
//    TextfieldView()
//}
