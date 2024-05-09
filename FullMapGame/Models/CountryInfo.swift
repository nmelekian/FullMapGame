//
//  CountryInfo.swift
//  FullMapGame
//
//  Created by Nick Melekian on 4/12/24.
//

import Foundation

struct Response: Codable, Hashable{
    var countries: [CountryInfo]
}

struct CountryInfo: Codable, Hashable {
    var name: Name
    var flags: Flags
    var capital: [String]
}

struct Name: Codable, Hashable {
    var common: String
    var official: String
    
}

struct Flags: Codable, Hashable{
    var png: String
}
