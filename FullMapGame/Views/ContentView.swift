//
//  ContentView.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var vm = CountriesViewModel()
    @State private var position: MapCameraPosition = .automatic
    @State var testCountry = 0
    @State var mapStyle: MapStyle = .imagery
    @State private var score = 0
    var body: some View {
        ZStack{
            Map(position: $position) {
                ForEach(vm.borderArray, id: \.self) { border in
                    MapPolygon(coordinates: border)
                        .foregroundStyle(.red.opacity(0.7
                                                     ))
                }
            }

            VStack {
                //                    Annotation("", coordinate: vm.userGuess.coordinate) {
                //                            Image(systemName: "star.circle")
                //                                .resizable()
                //                                .foregroundColor(.red)
                //                                .frame(width: 44, height: 44)
                //                                .background(.white)
                //                                .clipShape(Circle())
                Text(vm.currentCountryName)
                    .font(.title)
                Spacer()
            }
        }
        .mapStyle(mapStyle)
        
        // leave this commented out until I figure out how to make this work lol
        //            .onMapCameraChange { MapCameraUpdateContext in
        //                vm.userLatitude = MapCameraUpdateContext.camera.centerCoordinate.latitude
        //                vm.userLongitude = MapCameraUpdateContext.camera.centerCoordinate.longitude
        //            }
        ////
        //
        //            Circle()
        //                .fill(.blue)
        //                .opacity(0.3)
        //                .frame(width: 32, height: 32)
        //            Image(systemName: "cross.fill")
        //                .opacity(0.3)
        //                .font(.headline)
        //
        //            VStack{
        //
        //                Text("\(vm.currentCountryName)")
        //                    .font(.title)
        //
        //                Spacer()
        //            }
        //        }
        
        VStack {
            Text("Loaded Countries: \(vm.country.north)")
            Text("User Score: \(score)")
            TextField("Name the country", text: $vm.userGuessesText)
            //            Text(vm.userLatitude.description)
            //            Text(vm.userLongitude.description)
            //            Text("Find: \(vm.randomCountry.country)")
            //            Text(randomCountry.borders.count.description)
            //            Button("Place Guess") {
            //                vm.hasUserGuessed = true
            //                vm.addPlayerGuess()
            //                print(vm.userGuess.coordinate)
            //
            //            }
            Button("Guess") {
                //                vm.IncreasePlayerScore()
                //                vm.hasUserGuessed = true
                vm.currentCountryName = vm.randomCountry.country
                print(vm.randomCountry.country)
                mapStyle = .hybrid(pointsOfInterest: .excludingAll)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    if vm.userGuessesText == vm.currentCountryName {
                        score += 1
                    }
                    position = .automatic
                    vm.currentCountryName = ""
                    vm.userGuessesText = ""
                    mapStyle = .imagery
                    
                    
                    Task{
                        vm.randomCountry = await Bundle.main.decode("\(countryNames.randomElement()!).json")
                        vm.borderArray = vm.randomCountry.borders()
                        print(vm.randomCountry.borders().count.description)
                    }
                    
                   
                    //                    vm.hasUserGuessed = false
                    
                }
            }
            Button("load Country") {
                Task{
                    vm.randomCountry = await Bundle.main.decode("\(countryNames.randomElement()!).json")
                    vm.borderArray = vm.randomCountry.borders()
                }
                print(vm.borderArray.count.description)
                print(vm.randomCountry.country)
                testCountry += 1
                if testCountry == 204 {
                    testCountry = 0
                }
                position = .automatic
            }
            
            Button("poopoo") {
                vm.hasUserGuessed = true
                Task{
                    vm.randomCountry = await Bundle.main.decode("Canada.json")
                    vm.borderArray = vm.randomCountry.borders()

                }
                                //                print(vm.borderArray[0][1000])
                print(vm.randomCountry.country)
                //                testCountry += 1
                //                if testCountry == 204 {
                //                    testCountry = 0
                //                }
                position = .automatic
            }
        }
        .padding()
        .onSubmit {
            vm.currentCountryName = vm.country.country
            print(vm.randomCountry.country)
            mapStyle = .hybrid(pointsOfInterest: .excludingAll)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                if vm.userGuessesText == vm.currentCountryName {
                    score += 1
                }
                Task{
                    vm.randomCountry = await Bundle.main.decode("\(countryNames.randomElement()!).json")
                    vm.borderArray = vm.randomCountry.borders()
                    vm.country = vm.randomCountry
                }
                
                position = .automatic
                vm.currentCountryName = ""
                vm.userGuessesText = ""
                //                    vm.hasUserGuessed = false
                mapStyle = .imagery
            }
            
        }
    }
}


//#Preview {
//    ContentView()
//}


/*
 user coordinate inputted
 compare border points of target country
 compare distance between userpoint and border point
 
turn green when correct
fills in country if correct
 average points to try to pare down graphics rendering
 
 Country name bank
 Autocorrect/fill in
 
 Continent reference
 
 add a game of states?
 
 */
