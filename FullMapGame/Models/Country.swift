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
       
        if country == "Canada" || country == "United States" || country == "Russia" || country == "Indonesia" {
            for landmass in coordinatesArray {
                var coord2DArray: [CLLocationCoordinate2D] = []
                for index in 0..<landmass.count {
                    guard index == 0 || index % 30 == 0 else { continue }
                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                    coord2DArray.append(coord2D)
                    
                }
                coordArray.append(coord2DArray)
            }
        } else if country == "Vatican City" {
            for landmass in coordinatesArray {
                var coord2DArray: [CLLocationCoordinate2D] = []
                for index in 0..<landmass.count {
                    guard index == 0 || index % 1 == 0 else { continue }
                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                    coord2DArray.append(coord2D)
                    
                }
                coordArray.append(coord2DArray)
            }
        }
        else{
            for landmass in coordinatesArray {
                var coord2DArray: [CLLocationCoordinate2D] = []
                for index in 0..<landmass.count {
                    guard index == 0 || index % 5 == 0 else { continue }
                    let coord2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(landmass[index][1]), longitude: CLLocationDegrees(landmass[index][0]))
                    coord2DArray.append(coord2D)
                    
                }
                coordArray.append(coord2DArray)
            }
        }
        
        if coordArray.count > 100 {
          coordArray = Array(coordArray.sorted(by: { landmass1, landmass2 in
                landmass1.count > landmass2.count})[0..<30])
        }
        
        return coordArray
    }



static var testCountry = Country(country: "", city: "", north: 0, south: 0, west: 0, east: 0, jsonBorder: [[[[2.0]]]])
    
    
    
}

let countryNames = ["Afghanistan",
                    "Albania",
                    "Algeria",
                    "Andorra",
                    "Angola",
                    "Anguilla",
                    "Antigua and Barbuda",
                    "Argentina",
                    "Armenia",
                    "Aruba",
                    "Australia",
                    "Austria",
                    "Azerbaijan",
                    "Bahamas",
                    "Bahrain",
                    "Bangladesh",
                    "Barbados",
                    "Belarus",
                    "Belgium",
                    "Belize",
                    "Benin",
                    "Bermuda",
                    "Bhutan",
                    "Bolivia",
                    "Bosnia and Herzegovina",
                    "Botswana",
                    "Brazil",
                    "Brunei",
                    "Bulgaria",
                    "Burkina Faso",
                    "Burundi",
                    "Cambodia",
                    "Cameroon",
                    "Canada",
                    "Cabo Verde",
                    "Cayman Islands",
                    "Central African Republic",
                    "Chad",
                    "Chile",
                    "China",
                    "Christmas Island",
                    "Colombia",
                    "Comoros",
                    "Cook Islands",
                    "Costa Rica",
                    "Croatia",
                    "Cuba",
                    "Cyprus",
                    "Czech Republic",
                    "Denmark",
                    "Djibouti",
                    "Dominica",
                    "Dominican Republic",
                    "East Timor",
                    "Ecuador",
                    "Egypt",
                    "El Salvador",
                    "Equatorial Guinea",
                    "Eritrea",
                    "Estonia",
                    "Ethiopia",
                    "Faroe Islands",
                    "Finland",
                    "France",
                    "French Guiana",
                    "Gabon",
                    "Gambia",
                    "Georgia",
                    "Germany",
                    "Ghana",
                    "Greece",
                    "Grenada",
                    "Guadeloupe",
                    "Guatemala",
                    "Guinea",
                    "Guinea-Bissau",
                    "Guyana",
                    "Haiti",
                    "Vatican City",
                    "Honduras",
                    "Hungary",
                    "Iceland",
                    "India",
                    "Indonesia",
                    "Iran",
                    "Iraq",
                    "Ireland",
                    "Israel",
                    "Italy",
                    "Ivory Coast",
                    "Jamaica",
                    "Japan",
                    "Jordan",
                    "Kazakhstan",
                    "Kenya",
                    "Kiribati",
                    "Kuwait",
                    "Kyrgyzstan",
                    "Laos",
                    "Latvia",
                    "Lebanon",
                    "Lesotho",
                    "Liberia",
                    "Liechtenstein",
                    "Lithuania",
                    "Luxembourg",
                    "North Macedonia",
                    "Madagascar",
                    "Malawi",
                    "Malaysia",
                    "Maldives",
                    "Mali",
                    "Malta",
                    "Marshall Islands",
                    "Martinique",
                    "Mauritania",
                    "Mauritius",
                    "Mexico",
                    "Federated States of Micronesia",
                    "Moldova",
                    "Monaco",
                    "Mongolia",
                    "Montenegro",
                    "Morocco",
                    "Mozambique",
                    "Myanmar",
                    "Namibia",
                    "Nauru",
                    "Nepal",
                    "Netherlands",
                    "New Zealand",
                    "Nicaragua",
                    "Niger",
                    "Nigeria",
                    "Niue",
                    "North Korea",
                    "Norway",
                    "Oman",
                    "Pakistan",
                    "Palau",
                    "Palestine",
                    "Panama",
                    "Papua New Guinea",
                    "Paraguay",
                    "Peru",
                    "Philippines",
                    "Poland",
                    "Portugal",
                    "Qatar",
                    "Reunion",
                    "Romania",
                    "Russia",
                    "Rwanda",
                    "Saint Kitts and Nevis",
                    "Saint Lucia",
                    "Saint Vincent and the Grenadines",
                    "Samoa",
                    "San Marino",
                    "Sao Tome and Principe",
                    "Saudi Arabia",
                    "Senegal",
                    "Serbia",
                    "Seychelles",
                    "Sierra Leone",
                    "Singapore",
                    "Slovakia",
                    "Slovenia",
                    "Solomon Islands",
                    "Somalia",
                    "South Africa",
                    "South Korea",
                    "South Sudan",
                    "Spain",
                    "Sri Lanka",
                    "Sudan",
                    "Suriname",
                    "Eswatini",
                    "Sweden",
                    "Switzerland",
                    "Syria",
                    "Tajikistan",
                    "Tanzania",
                    "Thailand",
                    "Democratic Republic of the Congo",
                    "Togo",
                    "Tonga",
                    "Trinidad and Tobago",
                    "Tunisia",
                    "Turkey",
                    "Turkmenistan",
                    "Turks and Caicos Islands",
                    "Tuvalu",
                    "Uganda",
                    "Ukraine",
                    "United Arab Emirates",
                    "United Kingdom",
                    "United States",
                    "Uruguay",
                    "Uzbekistan",
                    "Vanuatu",
                    "Venezuela",
                    "Vietnam",
                    "Western Sahara",
                    "Yemen",
                    "Zambia",
                    "Zimbabwe",
                    "Republic of the Congo"
]
