//
//  CountryNameGuessView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 5/1/24.
//

import SwiftUI

struct CountryNameGuessView: View {
    @StateObject var vm: CountriesViewModel
    @State private var alertShowing = false
    var currentCountryFlag: CountryInfo {
        vm.countryInfo.first { country in
            country.name.common == vm.currentName
        } ?? vm.countryInfo[0]
    }
    var body: some View {
        VStack {
            HStack(alignment:.center){
                Button("Menu") {
                    alertShowing = true
                    
                }
                .padding(5)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                .padding(.leading)
                .alert("Return to Menu?", isPresented: $alertShowing) {
                    Button("Keep Playing", role: .cancel) { }
                    Button("Go To Menu", role: .destructive) {
                        vm.gameplay = .menu
                        vm.recentGuesses = []
                        vm.currentGameCountriesCountIndex = 0
                        vm.gameCount = 0
                        vm.score = 0
                        vm.continent = .noChoice
                    }
                    
                }
                Spacer()
                if vm.userHintEnabled {
                    VStack(spacing: 5){
                        Text("Capital City:")
                            .font(.system(size: 25))
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)
                            .padding([.leading,.trailing])
                        Text(vm.userHintText)
                            .font(.system(size: 25))
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)
                            .padding([.leading,.trailing])
                    }
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                    .padding(.trailing, 4)
                    
                }
                if vm.hasUserGuessed {
                    VStack(alignment: .center){
                        if vm.continent != .usStates{
                            Text(vm.currentName)
                                .font(.system(size: 25))
                                .lineLimit(1)
                                .minimumScaleFactor(0.3)
                                .padding([.top,.leading,.trailing])
                            AsyncImage(
                                url: URL(string: currentCountryFlag.flags.png) ,
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 50, maxHeight: 50)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            ).padding([.bottom,.leading,.trailing])
                        } else {
                            Text(vm.currentName)
                                .font(.system(size: 25))
                                .lineLimit(1)
                                .minimumScaleFactor(0.3)
                                .padding()
                        }
                    }
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                    .padding(.trailing, 4)
                    
                }
                Spacer()
                Button(action: {
                    vm.position = .automatic
                }, label: {
                    Image(systemName: "location")
                        .font(.title2)
                        .padding(5)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                })
                .padding(.trailing)
            }
            Spacer()
            HStack{
             
                Text("Score: \(vm.score)")
                    .font(.title3)
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                    .padding([.leading, .bottom], 2)
                
                Spacer()
                Button(action: {
                    vm.userHintText = vm.country.city
                    vm.userHintEnabled.toggle()
                }, label: {
                    Text("Hint")
                        .font(.title3)
                        .padding()
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                        .padding([.leading, .bottom], 2)
                        
                })
                .disabled(vm.userHintEnabled)
            }
        }
    }
}

