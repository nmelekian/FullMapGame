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
                
                if vm.randomCountry.country == "Tuvalu" || vm.randomCountry.country == "Vanuatu" || vm.randomCountry.country == "Cook Islands" || vm.randomCountry.country == "Marshall Islands" ||  vm.randomCountry.country == "Federated States of Micronesia" {
                    
                    MapPolygon(coordinates: vm.randomCountry.createCircleCoordinates(north: vm.randomCountry.north, south: vm.randomCountry.south, east: vm.randomCountry.east, west: vm.randomCountry.west, numOfPoints: 100))
                        .foregroundStyle(.green.opacity(0.2))
                        
                }
                
                ForEach(vm.borderArray, id: \.self) { border in
                    if vm.continent == .usStates{
                        MapPolygon(coordinates: border)
                            .foregroundStyle(vm.userGuessCorrect ? .green.opacity(0.7) : .red.opacity(0.7))
                        
                    }
                    else {
                        
                        MapPolygon(coordinates: border)
                            .foregroundStyle(vm.userGuessCorrect ? .green.opacity(0.7) : .red.opacity(0.7))
                    }
                }
            }
            .mapControlVisibility(.hidden)
            CountryNameGuessView(vm: vm)
        }
        .toolbar {
            
        }
        .mapStyle(vm.mapStyle)
    }
}

#Preview {
    MapView(vm: CountriesViewModel())
}
