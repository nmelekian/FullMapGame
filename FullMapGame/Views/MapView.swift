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
                    MapPolygon(coordinates: border)
                        .foregroundStyle(.red.opacity(0.7))
                }
            }
            
            VStack {
                Text(vm.currentCountryName)
                    .font(.title)
                Spacer()
            }
        }
        .mapStyle(vm.mapStyle)
    }
}

#Preview {
    MapView(vm: CountriesViewModel())
}
