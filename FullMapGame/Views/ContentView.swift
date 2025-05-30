//
//  ContentView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var vm: CountriesViewModel
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


func choice(introArray: [String], choice1: String, choice2: String, choice3: String, defaulted: String) {
    for line in introArray {
        print(line)
    }
    
    var hasChosen = false
    
    while !hasChosen {
        if let choice = readLine() {
            switch choice {
            case "1" :
                print(choice1)
                hasChosen = true
            case "2":
                print(choice2)
                hasChosen = true
            case "3":
                print(choice3)
                hasChosen = true
            default:
                print(defaulted)
            }
        }
    }
}
