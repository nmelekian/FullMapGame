//
//  CountriesViewModel.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/15/24.
//

import Foundation
import MapKit

@MainActor
class CountriesViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var randomCountry: Country = Country.testCountry
    @Published var borderArray: [[CLLocationCoordinate2D]] = []
    @Published var currentCountryName = ""
    
    
    @Published var userScore = 0
    @Published var hasUserGuessed = false
    @Published var userLatitude: CLLocationDegrees = 0
    @Published var userLongitude: CLLocationDegrees = 0
    @Published var userGuesses: [UserMapGuess] = []
    @Published var userGuess: UserMapGuess = UserMapGuess.userGuessTest
    @Published var userGuessesText = ""

    
    
    
//    func addPlayerGuess() {
//        
//        userGuess = UserMapGuess(name: "Player Guess", latitude: userLatitude, longitude: userLongitude)
//        
////        let playerGuess = UserMapGuess(name: "player guess \(UUID())", latitude: userLatitude, longitude: userLongitude)
////        userGuesses.append(playerGuess)
//    }
    
    
//    func IncreasePlayerScore() {
//        if userGuess == randomCountry.country {
//            userScore += 1
//        }
//    }
    
    
    
    
    init() { // is synchronous
        Task {
            let countries = await Bundle.main.decode("FullCountryInformation.json")
//            await MainActor.run {
                self.countries = countries
//            }
//         who knows how long this will take, but at least the user can use the app while the countries are being fetched.
        }
    }
}
