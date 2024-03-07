//
//  ContentView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var vm = CountriesViewModel()
    @FocusState var isFocused
    var body: some View {
        VStack {
            MapView(vm: vm)
            
            
            //            Text("Loaded Countries: \(vm.countries.count.description)")
            Text("User Score: \(vm.score)")
            TextField("Name the country", text: $vm.userGuessesText)
                .keyboardType(.alphabet)
                .autocorrectionDisabled()
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
            
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                SuggestionScrollView(vm: vm)
            }
        }
        .onSubmit {
            vm.playerSubmit()
        }
        .onAppear(perform: {
            Task{
                for name in countryNames {
                    let country = await Bundle.main.decode("\(name).json")
                    vm.countries.append(country)
                }
            }
        })
        
    }
}


//#Preview {
//    ContentView()
//}


/*
 user coordinate inputted
 compare border points of target country
 compare distance between userpoint and border point
 
 turn green when correct
 fills in country if correct
 average points to try to pare down graphics rendering
 
 Country name bank
 Autocorrect/fill in
 
 Continent reference
 
 add a game of states?
 
 */
