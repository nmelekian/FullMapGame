//
//  MenuOptionsView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 5/1/24.
//

import SwiftUI

struct MenuOptionsView: View {
    @StateObject var vm: CountriesViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.white)
                .opacity(0.6)
            VStack{
                Text("CountryGuessr")
                    .font(.title)
                    .bold()
                VStack{
                    Text("Select Continent: ")
                    Picker("Select continent", selection: $vm.continent) {
                        ForEach(Continent.allCases, id: \.self) { continent in
                            Text("\(continent.rawValue)")
                        }
                    }
                    .pickerStyle(.menu)
                }
                VStack{
                    Text("Select Number of Countries: ")
                    Picker("Select continent", selection: $vm.currentGameCountriesCountIndex) {
                        ForEach(vm.gameCounts, id: \.self) { amount in
                            Text("\(amount)").tag("")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Button("Play Game") {
                    vm.gameplay = .game
                    vm.continentSelect(continent: vm.continent)
                    vm.recentGuesses = []
                    if vm.continent == .usStates {
                        vm.borderArray = vm.currentState.borders()
                    }
                }
                .buttonStyle(.borderedProminent)
                
//                        Button("print country info") {
//                            print(vm.countryInfo.count.description)
//                        }
            }
        }
    }
}


