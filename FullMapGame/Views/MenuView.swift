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
    @State private var allStates = [USState]()
    var body: some View {
        if vm.allcountries.count >= 70 {
            ZStack{
                BackgroundMapView()
                    .opacity(0.65)
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.white)
                        .opacity(0.6)
                        .frame(width: 400, height: 300)
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
//                           
//                            
//                        }
                    }
                }.onChange(of: vm.continent) { _, newValue in
                    vm.gameCounts[3] = newValue.countrycount
                    if newValue == .usStates {
                        vm.borderArray = vm.allStates.randomElement()!.borders()
                    }
                }
                
                
                }
        } else {
                LottieView(lottieFile: "globe", animationSpeed: 2)
                .frame(width: 200, height: 200)
                    .onAppear(perform: {
                    Task{
                        for name in countryNames {
                            let country = await Bundle.main.decode("\(name).json")
                            allCountries.append(country)
                        }
                        for state in AmericanStatesDecode {
                            let usState = await Bundle.main.decodeState("\(state).json")
                            vm.allStates.append(usState)
                        }
                        vm.allcountries = allCountries
                        vm.countryInfo = await fetchCountryInfo()
                    }
                    
                })
            }
        
    }
}


