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
        GeometryReader { geometry in
            if vm.allcountries.count >= 70 {
                ZStack{
                    BackgroundMapView()
                        .opacity(0.65)
                    MenuOptionsView(vm: vm)
                        .frame(maxWidth: geometry.size.width * 0.67, maxHeight: geometry.size.height
                               * 0.33)
                        .padding()
                        .onChange(of: vm.continent) { _, newValue in
                            vm.gameCounts[3] = newValue.countrycount
                            if newValue == .usStates {
                                vm.borderArray = vm.allStates.randomElement()!.borders()
                            }
                        }
                    
                    
                }
            } else {
                LottieView(lottieFile: "globe", animationSpeed: 2)
                //                .frame(width: 200, height: 200)
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
                            
                        }
                        Task {
                            vm.countryInfo = await fetchCountryInfo()
                        }
                        
                    })
            }
        }
        
    }
}


