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
    @State private var score = 0
    var body: some View {
        
        MapView(vm: vm)
        
        VStack {
            Text("Loaded Countries: \(vm.countries.count.description)")
            Text("User Score: \(score)")
            TextField("Name the country", text: $vm.userGuessesText)
            
            Button("Guess") {
                vm.playerSubmit()
                
            }
            Button("load Country") {
                Task{
                    vm.randomCountry = vm.countries.randomElement()!
                    vm.borderArray = vm.randomCountry.borders()
                    vm.country = vm.randomCountry
                }
                print(vm.randomCountry.country)
                vm.testCountry += 1
                if vm.testCountry == 204 {
                    vm.testCountry = 0
                }
                vm.position = .automatic
            }
//            Button("poopoo") {
//                vm.hasUserGuessed = true
//                Task{
//                    vm.randomCountry = await Bundle.main.decode("Russia.json")
//                    vm.borderArray = vm.randomCountry.borders()
//                }
//                print(vm.randomCountry.country)
//                vm.position = .automatic
//            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                SuggestionScrollView(vm: vm)
            }
        }
        .onSubmit {
            vm.playerSubmit()
        }
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
