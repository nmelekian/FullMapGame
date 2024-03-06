//
//  Coordinate Extensions.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Hashable, Codable {
    public func encode(to encoder: Encoder) throws {
        
    }
    
    public init(from decoder: Decoder) throws {
        self.init()
    }
    
    
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.latitude)
        hasher.combine(self.longitude)
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
       
        return lhs.latitude == rhs.latitude && lhs.longitude == lhs.longitude
    }
    
    
}
