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
    
    
    
    func playerSubmit() {
        currentCountryName = country.country
        print(randomCountry.country)
        mapStyle = .hybrid(pointsOfInterest: .excludingAll)
        let answer = answer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            Task{
                switch continent {
                case .noChoice:
                    randomCountry = allcountries.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Africa:
                    randomCountry = allcountries.filter{ Africa.contains($0.country)}.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Asia:
                    randomCountry = allcountries.filter{ Asia.contains($0.country)}.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Europe:
                    randomCountry = allcountries.filter{ Europe.contains($0.country)}.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .NorthAmerica:
                    randomCountry = allcountries.filter{ NorthAmerica.contains($0.country)}.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .SouthAmerica:
                    randomCountry = allcountries.filter{ SouthAmerica.contains($0.country)}.randomElement()!
                    borderArray = randomCountry.borders()
                    country = randomCountry
                case .Oceania:
                    randomCountry = allcountries.filter{ Oceania.contains($0.country)}.randomElement()!
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
            randomCountry = allcountries.randomElement()!
        case .Africa:
            randomCountry = allcountries.filter{ Africa.contains($0.country)}.randomElement()!
        case .Asia:
            randomCountry = allcountries.filter{ Asia.contains($0.country)}.randomElement()!
        case .Europe:
            randomCountry = allcountries.filter{ Europe.contains($0.country)}.randomElement()!
        case .NorthAmerica:
            randomCountry = allcountries.filter{NorthAmerica.contains($0.country)}.randomElement()!
        case .SouthAmerica:
            randomCountry = allcountries.filter{ SouthAmerica.contains($0.country)}.randomElement()!
        case .Oceania:
            randomCountry = allcountries.filter{ Oceania.contains($0.country)}.randomElement()!
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
            allcountries.append(firstCountry)
          
            randomCountry = allcountries.randomElement()!
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
