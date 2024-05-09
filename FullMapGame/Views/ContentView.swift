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

/*
 For continent/whole world selection count, make it go through the whole continent/all countries, no repetitions
 for any other count
 */

//#Preview {
//    ContentView()
//}

/*
 
 State Guesser:
 Zooms out slowly of the state, and the faster you answer, the more points you get
 Autocorrect/fill in
 */
