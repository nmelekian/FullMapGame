//
//  Continent.swift
//  FullMapGame
//
//  Created by Nick Melekian on 3/8/24.
//

import Foundation
enum Continent: String, CaseIterable {
    case noChoice = "All"
    case Africa = "Africa"
    case Asia = "Asia"
    case Europe = "Europe"
    case NorthAmerica = "North America"
    case SouthAmerica = "South America"
    case Oceania = "Oceania"
    
    
    var countrycount: Int {
        switch self {
            
        case .noChoice:
            return countryNames.count
        case .Africa:
            return AfricaCountries.count 
        case .Asia:
            return AsianCountries.count
        case .Europe:
            return EuropeCountries.count
        case .NorthAmerica:
            return NorthAmericaCountries.count
        case .SouthAmerica:
            return SouthAmericaCountries.count
        case .Oceania:
            return OceaniaCountries.count
        }
    }
    
}
