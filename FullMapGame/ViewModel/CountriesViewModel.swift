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
                switch continent {
                case .noChoice:
                    randomCountry = gameArray.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Africa:
                    let africaCountries = gameArray.filter{ AfricaCountries.contains($0.country)}
                    randomCountry = africaCountries.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Asia:
                    let asianCountries = gameArray.filter{ AsianCountries.contains($0.country)}
                    randomCountry = asianCountries.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Europe:
                    let europeanCountries = gameArray.filter{ EuropeCountries.contains($0.country)}
                    randomCountry = europeanCountries.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .NorthAmerica:
                    let northAmericanCountries = gameArray.filter{ NorthAmericaCountries.contains($0.country)}
                    randomCountry = northAmericanCountries.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .SouthAmerica:
                    let southAmericanContries = gameArray.filter{ SouthAmericaCountries.contains($0.country)}
                    randomCountry = southAmericanContries.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Oceania:
                    let oceania = gameArray.filter{ OceaniaCountries.contains($0.country)}
                    randomCountry = oceania.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                }
                
            }
            position = .automatic
            currentCountryName = ""
            userGuessesText = ""
            mapStyle = .imagery
        }
    }
    
    func continentSelect(continent: Continent) {
        
        switch continent {
        case .noChoice:
            randomCountry = gameArray.randomElement()!
        case .Africa:
            randomCountry = gameArray.filter{ AfricaCountries.contains($0.country)}.randomElement()!
        case .Asia:
            randomCountry = gameArray.filter{ AsianCountries.contains($0.country)}.randomElement()!
        case .Europe:
            randomCountry = gameArray.filter{ EuropeCountries.contains($0.country)}.randomElement()!
        case .NorthAmerica:
            randomCountry = gameArray.filter{NorthAmericaCountries.contains($0.country)}.randomElement()!
        case .SouthAmerica:
            randomCountry = gameArray.filter{ SouthAmericaCountries.contains($0.country)}.randomElement()!
        case .Oceania:
            randomCountry = gameArray.filter{ OceaniaCountries.contains($0.country)}.randomElement()!
        }
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
    
    func createGameTotal(gameTotal: Int) {
        for i in 0..<gameTotal {
            
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
