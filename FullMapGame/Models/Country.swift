//
//  Country.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import Foundation
import MapKit
import SwiftData


struct Country: Codable, Hashable {
    var country: String
    var city: String
    var north: Double
    var south: Double
    var west: Double
    var east: Double
    var jsonBorder: [[[[Double]]]]
    

    func normalizeLongitude(longitude: CLLocationDegrees) -> CLLocationDegrees {
        var normalized = longitude
        while normalized > 180 {
            normalized -= 360
        }
        while normalized < -180 {
            normalized += 360
        }
        return normalized
    }
    
    func createCircleCoordinates(north: CLLocationDegrees, south: CLLocationDegrees, east: CLLocationDegrees, west: CLLocationDegrees, numOfPoints: Int) -> [CLLocationCoordinate2D] {
        let center = CLLocationCoordinate2D(latitude: (north + south) / 2, longitude: (east + west) / 2)
        let radius = CLLocationDistance(abs(center.latitude - south))
        
        var coordinates = [CLLocationCoordinate2D]()
        
        let degreesPerPoint = 360.0 / Double(numOfPoints)
        
        for i in 0..<numOfPoints {
                let angle = degreesPerPoint * Double(i)
                let x = center.longitude + (radius * cos(angle * .pi / 180.0))
                let y = center.latitude + (radius * sin(angle * .pi / 180.0))
                let coordinate = CLLocationCoordinate2D(latitude: y, longitude: normalizeLongitude(longitude: x))
                coordinates.append(coordinate)
            }
        
        return coordinates
    }
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
                let orderedSet = Array(NSOrderedSet(array: coord2DArray)) as! [CLLocationCoordinate2D]
                coord2DArray = orderedSet
                
                coordArray.append(coord2DArray)
            }
        }
                else if  country == "Belize" || country == "Denmark" || country == "Chile" {
                    for landmass in coordinatesArray {
                        var coord2DArray: [CLLocationCoordinate2D] = []
                        for index in 0..<landmass.count {
                            guard index == 0 || index % 40 == 0 else { continue }
                            let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                            coord2DArray.append(coord2D)
        
                        }
                        let orderedSet = Array(NSOrderedSet(array: coord2DArray)) as! [CLLocationCoordinate2D]
                        coord2DArray = orderedSet
                        
                        coordArray.append(coord2DArray)
                    }
                }
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

//@Model
//class fullCountry: Hashable {
//    var country: String
//    var city: String
//    var north: Double
//    var south: Double
//    var west: Double
//    var east: Double
//    var jsonBorder: [[[[Double]]]]
//    
//    init(country: String, city: String, north: Double, south: Double, west: Double, east: Double, jsonBorder: [[[[Double]]]]) {
//        self.country = country
//        self.city = city
//        self.north = north
//        self.south = south
//        self.west = west
//        self.east = east
//        self.jsonBorder = jsonBorder
//    }
//    
//    func borders() -> [[CLLocationCoordinate2D]] {
//        let coordinatesArray = jsonBorder.flatMap { $0 }
//        
//        var coordArray: [[CLLocationCoordinate2D]] = []
//        
//        if country == "Canada" || country == "United States" || country == "Russia" || country == "Indonesia" || country == "Malaysia" || country == "Norway"{
//            for landmass in coordinatesArray {
//                var coord2DArray: [CLLocationCoordinate2D] = []
//                for index in 0..<landmass.count {
//                    guard index == 0 || index % 35 == 0 else { continue }
//                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
//                    coord2DArray.append(coord2D)
//                    
//                }
//                let orderedSet = Array(NSOrderedSet(array: coord2DArray)) as! [CLLocationCoordinate2D]
//                coord2DArray = orderedSet
//                
//                coordArray.append(coord2DArray)
//            }
//        }
//                else if  country == "Belize" || country == "Denmark" || country == "Chile" {
//                    for landmass in coordinatesArray {
//                        var coord2DArray: [CLLocationCoordinate2D] = []
//                        for index in 0..<landmass.count {
//                            guard index == 0 || index % 40 == 0 else { continue }
//                            let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
//                            coord2DArray.append(coord2D)
//        
//                        }
//                        let orderedSet = Array(NSOrderedSet(array: coord2DArray)) as! [CLLocationCoordinate2D]
//                        coord2DArray = orderedSet
//                        
//                        coordArray.append(coord2DArray)
//                    }
//                }
//        else{
//            for landmass in coordinatesArray {
//                var coord2DArray: [CLLocationCoordinate2D] = []
//                for index in 0..<landmass.count {
//                    guard index == 0 || index % 1 == 0 else { continue }
//                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
//                    coord2DArray.append(coord2D)
//                    
//                    
//                }
//                let orderedSet = Array(NSOrderedSet(array: coord2DArray)) as! [CLLocationCoordinate2D]
//                coord2DArray = orderedSet
//                
//                coordArray.append(coord2DArray)
//            }
//        }
//        
//        if coordArray.count > 100 {
//            coordArray = Array(coordArray.sorted(by: { landmass1, landmass2 in
//                landmass1.count > landmass2.count})[0..<30])
//        }
//        
//        return coordArray
//    }
//}
//
