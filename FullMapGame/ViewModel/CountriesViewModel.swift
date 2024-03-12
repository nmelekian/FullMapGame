//
//  CountriesViewModel.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/15/24.
//

import Foundation
import MapKit
import SwiftUI
import Photos

@MainActor
class CountriesViewModel: ObservableObject {
    @Published var country: Country = .testCountry
    @Published var randomCountry: Country = .testCountry
    @Published var allcountries: [Country] = []
    @Published var borderArray: [[CLLocationCoordinate2D]] = []
    @Published var currentCountryName = ""
    @Published var currentCountriesArray: [Country] = []
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
    @Published var recentGuesses = [String]()
    
    
    func playerSubmit() {
        currentCountryName = country.country
        print(randomCountry.country)
        mapStyle = .hybrid(pointsOfInterest: .excludingAll)
        answer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            Task{
                //change these to reflect working off of the shortened array
                switch continent {
                case .noChoice:
                    nextRound(array: allcountries)
                case .Africa:
                    let africaCountries = allcountries.filter{ AfricaCountries.contains($0.country)}
                    nextRound(array: africaCountries)
                case .Asia:
                    let asianCountries = allcountries.filter{ AsianCountries.contains($0.country)}
                    nextRound(array: asianCountries)
                case .Europe:
                    let europeanCountries = allcountries.filter{ EuropeCountries.contains($0.country)}
                    print(europeanCountries.count)
                    nextRound(array: europeanCountries)
                case .NorthAmerica:
                    let northAmericanCountries = allcountries.filter{ NorthAmericaCountries.contains($0.country)}
                    nextRound(array: northAmericanCountries)
                case .SouthAmerica:
                    let southAmericanContries = allcountries.filter{ SouthAmericaCountries.contains($0.country)}
                    nextRound(array: southAmericanContries)
                case .Oceania:
                    let oceania = allcountries.filter{ OceaniaCountries.contains($0.country)}
                    nextRound(array: oceania)
                }
                
            }
            position = .automatic
            currentCountryName = ""
            userGuessesText = ""
            mapStyle = .imagery
        }
    }
    
    func nextRound(array: [Country]) {
        print(array.count)
        recentGuesses.append(country.country)
        print(recentGuesses)
        randomCountry = array.randomElement()!
        if recentGuesses.contains(randomCountry.country) {
            randomCountry = array.randomElement()!
        }
        if recentGuesses.count == 50{
            for i in 0...2 {
                recentGuesses.remove(at: i)
            }
        }
        borderArray = randomCountry.borders()
        country = randomCountry
    }
    
    func continentSelect(continent: Continent) {
        
        switch continent {
        case .noChoice:
            randomCountry = allcountries.randomElement()!
        case .Africa:
            randomCountry = allcountries.filter{ AfricaCountries.contains($0.country)}.randomElement()!
        case .Asia:
            randomCountry = allcountries.filter{ AsianCountries.contains($0.country)}.randomElement()!
        case .Europe:
            randomCountry = allcountries.filter{ EuropeCountries.contains($0.country)}.randomElement()!
        case .NorthAmerica:
            randomCountry = allcountries.filter{NorthAmericaCountries.contains($0.country)}.randomElement()!
        case .SouthAmerica:
            randomCountry = allcountries.filter{ SouthAmericaCountries.contains($0.country)}.randomElement()!
        case .Oceania:
            randomCountry = allcountries.filter{ OceaniaCountries.contains($0.country)}.randomElement()!
        }
        borderArray = randomCountry.borders()
        country = randomCountry
        position = .automatic
    }
    
    func answer(){
        
        if currentCountryName == userGuessesText {
            score += 1
            userCorrect.toggle()
        } else {
            userWrong.toggle()
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
                
        }
        
       
    }
}
