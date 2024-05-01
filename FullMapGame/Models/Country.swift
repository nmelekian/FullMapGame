//
//  Country.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import Foundation
import MapKit


struct Country: Codable, Hashable {
    var country: String
    var city: String
    var north: Double
    var south: Double
    var west: Double
    var east: Double
    var jsonBorder: [[[[Double]]]]
    func borders() -> [[CLLocationCoordinate2D]] {
        let coordinatesArray = jsonBorder.flatMap { $0 }
        
        var coordArray: [[CLLocationCoordinate2D]] = []
        
        if country == "Canada" || country == "United States" || country == "Russia" || country == "Indonesia" || country == "Malaysia" || country == "Norway"{
            for landmass in coordinatesArray {
                var coord2DArray: [CLLocationCoordinate2D] = []
                for index in 0..<landmass.count {
                    guard index == 0 || index % 35 == 0 else { continue }
                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                    coord2DArray.append(coord2D)
                    
                }
                coordArray.append(coord2DArray)
            }
        }
//        else if country == "Vatican City" || country == "Tuvalu" || country == "Vanuatu" || country == "Kiribati" || country == "Dominican Republic" || country == "Botswana" || country == "United Arab Emirates"  || country == "Yemen" || country == "Oman" || country == "Belize" || country == "Somalia"{
//            for landmass in coordinatesArray {
//                var coord2DArray: [CLLocationCoordinate2D] = []
//                for index in 0..<landmass.count {
//                    guard index == 0 || index % 1 == 0 else { continue }
//                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
//                    coord2DArray.append(coord2D)
//                    
//                }
//                coordArray.append(coord2DArray)
//            }
//        }
        else{
            for landmass in coordinatesArray {
                var coord2DArray: [CLLocationCoordinate2D] = []
                for index in 0..<landmass.count {
                    guard index == 0 || index % 1 == 0 else { continue }
                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                    coord2DArray.append(coord2D)
                    
                    
                }
                let orderedSet = Array(NSOrderedSet(array: coord2DArray)) as! [CLLocationCoordinate2D]
                coord2DArray = orderedSet
                
                coordArray.append(coord2DArray)
            }
        }
        
        if coordArray.count > 100 {
          coordArray = Array(coordArray.sorted(by: { landmass1, landmass2 in
                landmass1.count > landmass2.count})[0..<30])
        }
        
        return coordArray
    }

    static var testCountry = Country(country: "", city: "", north: 0, south: 0, west: 0, east: 0, jsonBorder: [[[[2.0,2.0]]]])

}

