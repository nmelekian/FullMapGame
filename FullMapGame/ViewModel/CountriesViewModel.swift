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
    @Published var userGuessCorrect = false
    
    
    
    @Published var position: MapCameraPosition = .automatic
    @Published var testCountry = 0
    @Published var mapStyle: MapStyle = .imagery
    @Published var score = 0
    @Published var continent: Continent = .noChoice

    @Published var userCorrect = false
    @Published var userWrong = false
    @Published var gameplay: Gameplay = .menu
    @Published var gameCounts = [10, 25, 50, 208]
    @Published var recentGuesses = [String]()
    @Published var hasGameCompleted = false
    
    
    @Published var currentState: USState = .testState
    @Published var allStates: [USState] = []
    @Published var countryInfo: [CountryInfo] = []
    @Published var userHintEnabled = false
    @Published var userHintText = ""
    
    /// Logic for player when they have typed their country and submit the answer
    func playerSubmit() {
        if currentState.stateName.lowercased() == userGuessesText.lowercased() {
            userGuessCorrect = true
        }
        if randomCountry.country.lowercased() == userGuessesText.lowercased() {
            userGuessCorrect = true
        }
        if continent == .usStates {
            currentName = currentState.stateName
        } else {
            currentName = country.country
        }
        mapStyle = .hybrid(pointsOfInterest: .excludingAll)
        userHintEnabled = false 
        answer()
        
    }
    
    func nextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            Task{
                //change these to reflect working off of the shortened array
                hasUserGuessed = false
                userGuessCorrect = false
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
    
    
    ///Starts next round of play for US States
    ///TODO: Refactor to make states and countries work in same function
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
                if usedArray.count == 1 {
                    hasGameCompleted = true
                }
                else {
                    currentState = usedArray.randomElement()!
                   
                }
            } else {
                
                recentGuesses.append(currentState.stateName)
                usedArray.removeAll { state in
                    recentGuesses.contains(state.stateName)
                }
                currentState = usedArray.randomElement()!
                
                if recentGuesses.count == 15{
                    for i in 0...4 {
                        recentGuesses.remove(at: i)
                    }
                }
                

               
            }
        borderArray = currentState.borders()
    
    }
    
    
    ///Begins next round of play for countries
    ///TODO: Work to refactor for countries and states
    func nextRound(array: [Country]) {
        var usedArray = array
//        print(usedArray.description)
        gameCount += 1
        if gameCount == currentGameCountriesCountIndex {
            hasGameCompleted = true
        }
        
            if currentGameCountriesCountIndex == gameCounts[3] {
                recentGuesses.append(country.country)
//                print(recentGuesses)
                usedArray.removeAll { country in
                    recentGuesses.contains(country.country)
                }
//                print(usedArray)
                if usedArray.count >= 1 {
                    randomCountry = usedArray.randomElement()!
                }
                else {
                    hasGameCompleted = true
                }
            } else {
                
                recentGuesses.append(country.country)

                usedArray.removeAll { country in
                    recentGuesses.contains(country.country)
                }
                randomCountry = usedArray.randomElement()!
//                if recentGuesses.contains(randomCountry.country) {
//                    randomCountry = usedArray.randomElement()!
//                }
                
                if recentGuesses.count == 13{
                    for i in 0...2 {
                        recentGuesses.remove(at: i)
                    }
                }
            }
        
            borderArray = randomCountry.borders()
            country = randomCountry
        
        
        
    }
    
    
    ///Selects the game continent/states for the current game
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
    
    ///Simple logic for scoring
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
        
            let firstCountry: Country = await Bundle.main.decode("\(countryNames.randomElement()!).json")
            allcountries.append(firstCountry)
          
            
            let firstState = await Bundle.main.decodeState("\(AmericanStatesDecode.randomElement()!).json")
            allStates.append(firstState)
            
            randomCountry = allcountries.randomElement()!
            borderArray = randomCountry.borders()
                
        }
        
       
    }
}
