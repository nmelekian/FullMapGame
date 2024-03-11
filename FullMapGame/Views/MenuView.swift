//
//  MenuView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/8/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject var vm: CountriesViewModel
    
    var body: some View {
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
                Picker("Select continent", selection: $vm.currentCountriesIndex) {
                    ForEach(vm.gameCounts, id: \.self) { amount in
                        Text("\(amount)").tag("")
                       }
                }
            }
            Button("Play Game") {
                vm.gameplay = .game
                vm.gameStart(continent: vm.continent)
            }
            .buttonStyle(.borderedProminent)
        }.onAppear(perform: {
            Task{
                for name in countryNames {
                    let country = await Bundle.main.decode("\(name).json")
                    vm.allcountries.append(country)
                }
            }
        })
        .onChange(of: vm.continent) { oldValue, newValue in
            vm.gameCounts[3] = newValue.countrycount
//            vm.gameArray = 
        }
    }
}


