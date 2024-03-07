//
//  SpareParts.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/20/24.
//

import Foundation
/*
 for landmass in borderSlice{
     var coord2DArray: [CLLocationCoordinate2D] = []
     let largestLandmass = borderSlice.first
     for index in  0..<largestLandmass!.count {
                   
 
         guard index + 1 < landmass.count,
               abs(landmass[index][0] - landmass[index + 1][0]) < 5,
               abs(landmass[index][1] - landmass[index + 1][1]) < 5  else {continue}
 
         let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
         coord2DArray.append(coord2D)
     }
     coordArray.append(coord2DArray)
 }
 
 
 
 
//        if coordinatesArray.count > 60 {
//            let borderSlice = Array(coordinatesArray.sorted(by: { landmass1, landmass2 in
//                landmass1.count > landmass2.count})[0..<30])
//            for landmass in borderSlice{
//                var coord2DArray: [CLLocationCoordinate2D] = []
//                for coord in landmass {
//                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(coord[1]), longitude: CLLocationDegrees(coord[0]))
//                    coord2DArray.append(coord2D)
//                }
//                coordArray.append(coord2DArray)
//            }
//
//
//        } else {
//            for landmass in coordinatesArray{
//                var coord2DArray: [CLLocationCoordinate2D] = []
//                for coord in landmass {
//                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(coord[1]), longitude: CLLocationDegrees(coord[0]))
//                    coord2DArray.append(coord2D)
//                }
//                coordArray.append(coord2DArray)
//            }
//        }
 
 
 
 
 // map camera change stuff
//         leave this commented out until I figure out how to make this work lol
//                    .onMapCameraChange { MapCameraUpdateContext in
//                        vm.userLatitude = MapCameraUpdateContext.camera.centerCoordinate.latitude
//                        vm.userLongitude = MapCameraUpdateContext.camera.centerCoordinate.longitude
//                    }
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
 
 //            Text(vm.userLatitude.description)
 //            Text(vm.userLongitude.description)
 //            Text("Find: \(vm.randomCountry.country)")
 //            Text(randomCountry.borders.count.description)
 //            Button("Place Guess") {
 //                vm.hasUserGuessed = true
 //                vm.addPlayerGuess()
 //                print(vm.userGuess.coordinate)
 //            }

 
 //                    Annotation("", coordinate: vm.userGuess.coordinate) {
 //                            Image(systemName: "star.circle")
 //                                .resizable()
 //                                .foregroundColor(.red)
 //                                .frame(width: 44, height: 44)
 //                                .background(.white)
 //   
 //                vm.IncreasePlayerScore()
 //                vm.hasUserGuessed = true
//                vm.currentCountryName = vm.country.country
//
//                print(vm.randomCountry.country)
//                mapStyle = .hybrid(pointsOfInterest: .excludingAll)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                    if vm.userGuessesText == vm.currentCountryName {
//                        score += 1
//                    }
//                    position = .automatic
//                    vm.currentCountryName = ""
//                    vm.userGuessesText = ""
//                    mapStyle = .imagery
//                    Task{
//                        vm.randomCountry = vm.countries.randomElement()!
//                        vm.borderArray = vm.randomCountry.borders()
//                        vm.country = vm.randomCountry
//                    }
     //                    vm.hasUserGuessed = false
 */
