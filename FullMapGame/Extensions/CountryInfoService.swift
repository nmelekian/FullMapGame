//
//  CountryInfoService.swift
//  FullMapGame
//
//  Created by Nick Melekian on 4/12/24.
//

import Foundation


func fetchCountryInfo() async {
    for country in countryNames{
        guard let url = URL(string: "https://restcountries.com/v3.1/name/\(country)") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
//                let loaded = try! JSONDecoder().decode([Country].self, from: data)
//                print(loaded)
            if let decodedResponse = try? JSONDecoder().decode([CountryInfo].self, from: data) {
//                response.countries += decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
//    for country in response.countries {
//        print(country.name.common)
//        print(country.capital.first ?? "none")
//    }
//    print(response.countries.count)
//    print(countryNames.count)
}
