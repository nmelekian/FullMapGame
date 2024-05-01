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
                            .foregroundStyle(vm.userGuessCorrect ? .green.opacity(0.7) : .red.opacity(0.7))
   
                    } else {
                        MapPolygon(coordinates: border)
                            .foregroundStyle(vm.userGuessCorrect ? .green.opacity(0.7) : .red.opacity(0.7))
                    }
                }
            }
            
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
