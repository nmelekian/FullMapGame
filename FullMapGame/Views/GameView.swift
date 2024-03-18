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

          TextfieldView(vm: vm, isFocused: _isFocused)
            
        }
        .sensoryFeedback(.success, trigger: vm.userCorrect)
        .sensoryFeedback(.error, trigger: vm.userWrong )
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                SuggestionScrollView(vm: vm)
            }
        }
        .onSubmit {
            vm.playerSubmit()
        }
        .alert("Game Over! You Scored \(vm.score) out of \(vm.currentGameCountriesCountIndex)!", isPresented: $vm.hasGameCompleted) {
            Button("Ok", role: .cancel) {
                vm.hasGameCompleted = false
                vm.gameplay = .menu
                vm.score = 0
            }
        }
//        .onChange(of: vm.continent) { oldValue, newValue in
//            vm.continentSelect(continent: newValue)
//        }
        
    }
    
}

//#Preview {
//    GameView()
//}
