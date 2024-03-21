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
    @Published var currentName = ""
    @Published var currentCountriesArray: [Country] = []
    @Published var currentGameCountriesCountIndex = 10
    
    @Published var gameCount = 0
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
    @Published var hasGameCompleted = false
    
    
    @Published var currentState: USState = .testState
    @Published var allStates: [USState] = []
    
    
    func playerSubmit() {
        
        if continent == .usStates {
            currentName = currentState.stateName
        } else {
            currentName = country.country
        }
        mapStyle = .hybrid(pointsOfInterest: .excludingAll)
        answer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
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
                case .usStates:
                    let allStates = allStates
                    nextStateRound(array: allStates)
                }
                
            }
            position = .automatic
            currentName = ""
            userGuessesText = ""
            mapStyle = .imagery
        }
    }
    
    func nextStateRound(array: [USState]) {
        var usedArray = array
        gameCount += 1
        if gameCount == currentGameCountriesCountIndex {
            hasGameCompleted = true
        }
        
            if currentGameCountriesCountIndex == gameCounts[3] {
                recentGuesses.append(currentState.stateName)
                usedArray.removeAll { state in
                    recentGuesses.contains(state.stateName)
                }
                currentState = usedArray.randomElement()!
            } else {
                
                recentGuesses.append(currentState.stateName)
                currentState = usedArray.randomElement()!
                if recentGuesses.contains(randomCountry.country) {
                    currentState = usedArray.randomElement()!
                }
                
                if recentGuesses.count == 10{
                    for i in 0...4 {
                        recentGuesses.remove(at: i)
                    }
                }
            }
        borderArray = currentState.borders()
    
    }
    
    func nextRound(array: [Country]) {
        var usedArray = array
        gameCount += 1
        if gameCount == currentGameCountriesCountIndex {
            hasGameCompleted = true
        }
        
            if currentGameCountriesCountIndex == gameCounts[3] {
                recentGuesses.append(country.country)
                usedArray.removeAll { country in
                    recentGuesses.contains(country.country)
                }
                randomCountry = usedArray.randomElement()!
            } else {
                
                recentGuesses.append(country.country)
                randomCountry = usedArray.randomElement()!
                if recentGuesses.contains(randomCountry.country) {
                    randomCountry = usedArray.randomElement()!
                }
                
                if recentGuesses.count == 6{
                    for i in 0...2 {
                        recentGuesses.remove(at: i)
                    }
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
        case .usStates:
            currentState = allStates.randomElement()!
        }
        borderArray = randomCountry.borders()
        country = randomCountry
        position = .automatic
    }
    
    func answer(){
        
        if currentName == userGuessesText {
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
          
            
            let firstState = await Bundle.main.decodeState("\(AmericanStatesDecode.randomElement()!).json")
            allStates.append(firstState)
            
            randomCountry = allcountries.randomElement()!
            borderArray = randomCountry.borders()
                
        }
        
       
    }
}
