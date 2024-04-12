//
//  MapView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/7/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var vm: CountriesViewModel
    var body: some View {
        ZStack{
            Map(position: $vm.position) {
                ForEach(vm.borderArray, id: \.self) { border in
                    if vm.continent == .usStates{
                        MapPolygon(coordinates: border)
                            .foregroundStyle(vm.currentState.stateName == vm.userGuessesText ? .green.opacity(0.7) : .red.opacity(0.7))
                        Annotation("", coordinate: border[0]) {
                            Button {
                                print("hi")
                            } label: {
                                Text("hi")
                            }

                        }

                        
                    } else {
                        MapPolygon(coordinates: border)
                            .foregroundStyle(vm.randomCountry.country == vm.userGuessesText ? .green.opacity(0.7) : .red.opacity(0.7))
                    }
                        
                        
                }
            }
            
            VStack {
                
                
                HStack(alignment:.center){
                    Text("Score: \(vm.score)")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding()
                    Spacer()
                    Text(vm.currentName)
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(.trailing)
                    Spacer()
                    Button(action: {
                        vm.position = .automatic
                    }, label: {
                        Image(systemName: "location.square")
                            .foregroundStyle(.white)
                            .font(.title2)
                    })
                    .padding()
                    
                }
                Spacer()
            }
        }
        .toolbar {
           
        }
        .mapStyle(vm.mapStyle)
    }
}

#Preview {
    MapView(vm: CountriesViewModel())
}
