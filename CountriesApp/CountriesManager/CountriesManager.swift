//
//  CountriesManager.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import Foundation

class CountriesManager {
    
    static let shared: CountriesManager = CountriesManager()
    
    var lastDetailed: CountryData?
}
