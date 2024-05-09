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
                        vm.hasUserGuessed = true
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
        .scrollBounceBehavior(.automatic)
        .scrollIndicators(.hidden)
        .scrollTargetLayout()
    }
    
    var searchResults: [String] {
        switch vm.continent {
        case .Africa:
            if vm.userGuessesText.isEmpty {
                return AfricaCountries.sorted()
            } else {
                return AfricaCountries.filter {$0.localizedStandardContains(vm.userGuessesText)}
            }
        case .NorthAmerica:
            if vm.userGuessesText.isEmpty {
                return NorthAmericaCountries.sorted()
            } else {
                return NorthAmericaCountries.filter {$0.localizedStandardContains(vm.userGuessesText)}
            }
        case .Asia:
            if vm.userGuessesText.isEmpty {
                return AsianCountries.sorted()
            } else {
                return AsianCountries.filter { $0.localizedStandardContains(vm.userGuessesText)}
            }
        case .Europe:
            if vm.userGuessesText.isEmpty {
                return EuropeCountries.sorted()
            } else {
                return EuropeCountries.filter { $0.localizedStandardContains(vm.userGuessesText)}
            }
        case .SouthAmerica:
            if vm.userGuessesText.isEmpty {
                return SouthAmericaCountries.sorted()
            } else {
                return SouthAmericaCountries.filter { $0.localizedStandardContains(vm.userGuessesText)}
            }
        case .Oceania:
            if vm.userGuessesText.isEmpty {
                return OceaniaCountries.sorted()
            } else {
                return OceaniaCountries.filter { $0.localizedStandardContains(vm.userGuessesText)}
            }
        case .noChoice:
            if vm.userGuessesText.isEmpty {
                return countryNames.sorted()
            } else {
                return countryNames.filter {$0.localizedStandardContains(vm.userGuessesText)}
            }
        case .usStates:
            if vm.userGuessesText.isEmpty {
                return AmericanStates.sorted()
            } else {
                return AmericanStates.filter {$0.localizedStandardContains(vm.userGuessesText)}
            }
        }
    }
}

