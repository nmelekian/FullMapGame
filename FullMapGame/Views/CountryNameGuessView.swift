//
//  CountryNameGuessView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 5/1/24.
//

import SwiftUI

struct CountryNameGuessView: View {
    @StateObject var vm: CountriesViewModel
    var currentCountryFlag: CountryInfo {
        vm.countryInfo.first { country in
            country.name.common == vm.currentName
        } ?? vm.countryInfo[0]
    }
    var body: some View {
        VStack {
            HStack(alignment:.center){
                Button("Menu") {
                    vm.gameplay = .menu
                    vm.recentGuesses = []
                    vm.currentGameCountriesCountIndex = 0
                    vm.gameCount = 0
                    vm.score = 0
                    vm.continent = .noChoice
                }
                .padding(5)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 6)
                Spacer()
                if vm.hasUserGuessed {
                    VStack(alignment: .center){
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
                    }
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                    .padding(.trailing, 4)
                  
                }
                Spacer()
                Button(action: {
                    vm.position = .automatic
                }, label: {
                    Image(systemName: "location.square")
                        .font(.title2)
                        .padding(5)
                        .background(.regularMaterial, in: Capsule())
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
            }
        }
    }
}

