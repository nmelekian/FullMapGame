//
//  SuggestionScrollView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/7/24.
//

import SwiftUI

struct SuggestionScrollView: View {
    @StateObject var vm: CountriesViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(searchResults, id: \.self) { country in
                    Button(country) {
                        vm.userGuessesText = country
                    }
                    .padding(2)
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
    }
    
    var searchResults: [String] {
        if vm.userGuessesText.isEmpty {
            return countryNames
        } else {
            return countryNames.filter { $0.contains(vm.userGuessesText)}
        }
    }
}

