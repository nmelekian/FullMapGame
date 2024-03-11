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
    @Published var allcountries: [Country] = []
    @Published var borderArray: [[CLLocationCoordinate2D]] = []
    @Published var currentCountryName = ""
    @Published var gameArray: [Country] = []
    @Published var currentCountriesIndex = 10
    
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
    @Published var continent: Continent = .noChoice

    @Published var userCorrect = false
    @Published var userWrong = false
    @Published var gameplay: Gameplay = .menu
    @Published var gameCounts = [10, 25, 50, 207]
    
    init() { // is synchronous
        Task {
            let firstCountry = await Bundle.main.decode("\(countryNames.randomElement()!).json")
            allcountries.append(firstCountry)
           gameArray = allcountries
            randomCountry = gameArray.randomElement()!
            borderArray = randomCountry.borders()
            country = randomCountry
        }
    }
    
    func playerSubmit() {
        currentCountryName = country.country
        print(randomCountry.country)
        mapStyle = .hybrid(pointsOfInterest: .excludingAll)
        let answer = answer()
        print(answer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            Task{
                //change these to reflect working off of the shortened array
                
                randomCountry = gameArray.randomElement()!
                borderArray = randomCountry.borders()
                country = randomCountry
            }
            position = .automatic
            currentCountryName = ""
            userGuessesText = ""
            mapStyle = .imagery
        }
    }
    
    
    func continentSelect(continent: Continent) -> [Country] {
        
        switch continent {
        case .noChoice:
            return gameArray
        case .Africa:
            return gameArray.filter{ AfricaCountries.contains($0.country)}
        case .Asia:
            return gameArray.filter{ AsianCountries.contains($0.country)}
        case .Europe:
            return gameArray.filter{ EuropeCountries.contains($0.country)}
        case .NorthAmerica:
            return gameArray.filter{NorthAmericaCountries.contains($0.country)}
        case .SouthAmerica:
            return gameArray.filter{ SouthAmericaCountries.contains($0.country)}
        case .Oceania:
            return gameArray.filter{ OceaniaCountries.contains($0.country)}
        }
        
    }
    
    func gameStart(continent: Continent) {
        randomCountry = continentSelect(continent: continent).randomElement()!
        borderArray = randomCountry.borders()
        country = randomCountry
        position = .automatic
    }
    
    
    func answer() -> Bool {
        
        if currentCountryName == userGuessesText {
            score += 1
            userCorrect.toggle()
            return userCorrect
            
        } else {
            userWrong.toggle()
            return userWrong
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
    
    
    
    
   
}
