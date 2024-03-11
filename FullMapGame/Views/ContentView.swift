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
        switch vm.gameplay {
        case .menu:
          MenuView(vm: vm)
        case .game:
            GameView(vm: vm, isFocused: _isFocused )
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
