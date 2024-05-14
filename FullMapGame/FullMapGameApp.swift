//
//  FullMapGameApp.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import SwiftUI
import SwiftData

@main
struct FullMapGameApp: App {
    @StateObject var viewModel = CountriesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
