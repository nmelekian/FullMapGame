//
//  MenuView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/8/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject var vm: CountriesViewModel
    @State private var allCountries = [Country]()
    var body: some View {
        if vm.allcountries.count >= 70 {
            VStack{
                Text("CountryGuessr")
                    .font(.title)
                    .bold()
                HStack{
                    Text("Select Continent: ")
                    Picker("Select continent", selection: $vm.continent) {
                        ForEach(Continent.allCases, id: \.self) { continent in
                            Text("\(continent.rawValue)")
                        }
                    }
                }
                HStack{
                    Text("Select Number of Countries: ")
                    Picker("Select continent", selection: $vm.currentGameCountriesCountIndex) {
                        ForEach(vm.gameCounts, id: \.self) { amount in
                            Text("\(amount)").tag("")
                        }
                    }
                }
                Button("Play Game") {
                    vm.gameplay = .game
                    vm.continentSelect(continent: vm.continent)
                }
                .buttonStyle(.borderedProminent)
            }.onChange(of: vm.continent) { _, newValue in
                vm.gameCounts[3] = newValue.countrycount
            }
        } else {
                ProgressView()
                    .onAppear(perform: {
                    Task{
                        for name in countryNames {
                            let country = await Bundle.main.decode("\(name).json")
                            allCountries.append(country)
                        }
                        vm.allcountries = allCountries
                    }
                })
            }
        
    }
}


