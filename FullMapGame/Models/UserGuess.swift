//
//  UserGuess.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/15/24.
//

import Foundation
import MapKit


struct UserMapGuess: Codable, Identifiable, Equatable{
    var id = UUID()
    
    var name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    
    static var userGuessTest = UserMapGuess(name: "Test", latitude: 0.0, longitude: 0.0)
    
}
