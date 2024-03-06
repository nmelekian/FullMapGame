//
//  Bundle Extension.swift
//  FullMapGame
//
//  Created by Nick Melekian on 2/14/24.
//

import Foundation

extension Bundle {
    
//    func decodeBorder(_ file: String) -> GEOJSON  {
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//        
//        let decoder = JSONDecoder()
//        
//        let loaded = try! decoder.decode(GEOJSON.self, from: data)
//        guard let loaded = try? decoder.decode(GEOJSON.self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle.")
//        }
//        
//        return loaded
//    }
    
    func decode(_ file: String) async -> [Country] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        let loaded = try! decoder.decode([Country].self, from: data)
        guard let loaded = try? decoder.decode([Country].self, from: data) else {
            return []
        }
        
        return loaded
    }
}
