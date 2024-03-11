//
//  GameView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/8/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var vm: CountriesViewModel
    @FocusState var isFocused
    var body: some View {
        VStack {
            MapView(vm: vm)
                .contentMargins(10)
            
            
            //            Text("Loaded Countries: \(vm.countries.count.description)")
            Text("User Score: \(vm.score)")
            
            TextField("Name the country", text: $vm.userGuessesText)
                .keyboardType(.alphabet)
                .autocorrectionDisabled()
                .focused($isFocused)
                .padding([.bottom, .horizontal])
                .onAppear {
                    isFocused = true
                }
            
        }
        .sensoryFeedback(.success, trigger: vm.userCorrect)
        .sensoryFeedback(.error, trigger: vm.userWrong )
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                SuggestionScrollView(vm: vm)
            }
        }
        .onSubmit {
            
        }
        .onChange(of: vm.continent) { oldValue, newValue in
            vm.continentSelect(continent: newValue)
        }
        
    }
    
}

//#Preview {
//    GameView()
//}
