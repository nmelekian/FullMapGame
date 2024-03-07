//
//  CountriesViewModel.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/15/24.
//

import Foundation
import MapKit
import SwiftUI

@MainActor
class CountriesViewModel: ObservableObject {
    @Published var country: Country = .testCountry
    @Published var randomCountry: Country = .testCountry
    @Published var countries: [Country] = []
    @Published var borderArray: [[CLLocationCoordinate2D]] = []
    @Published var currentCountryName = ""
    
    
    @Published var userScore = 0
    @Published var hasUserGuessed = false
    @Published var userLatitude: CLLocationDegrees = 0
    @Published var userLongitude: CLLocationDegrees = 0
    @Published var userGuesses: [UserMapGuess] = []
    @Published var userGuess: UserMapGuess = UserMapGuess.userGuessTest
    @Published var userGuessesText = ""
    
    
    @Published var position: MapCameraPosition = .automatic
    @Published var testCountry = 0
    @Published var mapStyle: MapStyle = .imagery
    @Published var score = 0

    
    
    
    
    func playerSubmit() {
        currentCountryName = country.country
        print(randomCountry.country)
        mapStyle = .hybrid(pointsOfInterest: .excludingAll)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
            if userGuessesText == currentCountryName {
                score += 1
            }
            Task{
                randomCountry = countries.randomElement()!
                borderArray = randomCountry.borders()
                country = randomCountry
            }
            position = .automatic
            currentCountryName = ""
            userGuessesText = ""
            mapStyle = .imagery
        }
    }
    
    
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
            let firstCountry = await Bundle.main.decode("\(countryNames.randomElement()!).json")
            countries.append(firstCountry)
          
            randomCountry = countries.randomElement()!
            borderArray = randomCountry.borders()
            country = randomCountry
                
            
//            Task{
//                for name in countryNames {
//                    let country = await Bundle.main.decode("\(name).json")
//                    countries.append(country)
//                }
//            }
        }
       
    }
}