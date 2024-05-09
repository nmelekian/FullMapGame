//
//  State.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/21/24.
//

import Foundation
import MapKit

struct USState: Codable, Hashable {
    var stateName: String
    var capital: String
    var jsonBorder: [[[[Double]]]]
    func borders() -> [[CLLocationCoordinate2D]] {
        let coordinatesArray = jsonBorder.flatMap { $0 }
        
        var coordArray: [[CLLocationCoordinate2D]] = []
        
        
            for landmass in coordinatesArray {
                var coord2DArray: [CLLocationCoordinate2D] = []
                for index in 0..<landmass.count {
                    guard index == 0 || index % 1 == 0 else { continue }
                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                    coord2DArray.append(coord2D)
                    
                }
                coordArray.append(coord2DArray)
            }
        if coordArray.count > 100 {
          coordArray = Array(coordArray.sorted(by: { landmass1, landmass2 in
                landmass1.count > landmass2.count})[0..<30])
        }
        
        return coordArray
    }
    
    static var testState = USState(stateName: "Herkadur", capital: "DinkyHoo", jsonBorder: [[[[0.0,0.0]]]])
}
