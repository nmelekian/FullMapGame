//
//  SuggestionScrollView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/7/24.
//

import SwiftUI

struct SuggestionScrollView: View {
    @StateObject var vm: CountriesViewModel
    @State private var isPressed = false

    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(searchResults, id: \.self) { country in
                    Button(country) {
                        isPressed = true
                        vm.userGuessesText = country
                        vm.playerSubmit()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isPressed = false
                        }
                    }
                    .padding(2)
                    .buttonStyle(.borderedProminent)
                    .disabled(isPressed)
                    
                }
            }
        }
    }
    
    var searchResults: [String] {
        switch vm.continent {
        case .Africa:
            if vm.userGuessesText.isEmpty {
                return Africa.sorted()
            } else {
                return Africa.filter { $0.contains(vm.userGuessesText)}
            }
        case .NorthAmerica:
            if vm.userGuessesText.isEmpty {
                return NorthAmerica.sorted()
            } else {
                return NorthAmerica.filter { $0.contains(vm.userGuessesText)}
            }
        case .Asia:
            if vm.userGuessesText.isEmpty {
                return Asia.sorted()
            } else {
                return Asia.filter { $0.contains(vm.userGuessesText)}
            }
        case .Europe:
            if vm.userGuessesText.isEmpty {
                return Europe.sorted()
            } else {
                return Europe.filter { $0.contains(vm.userGuessesText)}
            }
        case .SouthAmerica:
            if vm.userGuessesText.isEmpty {
                return SouthAmerica.sorted()
            } else {
                return SouthAmerica.filter { $0.contains(vm.userGuessesText)}
            }
        case .Oceania:
            if vm.userGuessesText.isEmpty {
                return Oceania.sorted()
            } else {
                return Oceania.filter { $0.contains(vm.userGuessesText)}
            }
        case .noChoice:
            if vm.userGuessesText.isEmpty {
                return countryNames.sorted()
            } else {
                return countryNames.filter { $0.contains(vm.userGuessesText)}
            }
        }
        
    }
}

