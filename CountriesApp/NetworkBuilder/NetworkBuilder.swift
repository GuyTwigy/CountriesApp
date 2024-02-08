//
//  NetworkBuilder.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import Foundation

class NetworkBuilder {
    
    enum ApiUrls {
        case countriesBaseUrl
        
        var description: String {
            switch self {
            case .countriesBaseUrl:
                return "https://restcountries.com/v3.1/all"
            }
        }
    }
    
    enum EndPoints {
        case querysCountries
        case searchByName
        
        var description: String {
            switch self {
            case .querysCountries:
                return "?fields=name,region,subregion,flag"
            case .searchByName:
                return "name/"
            }
        }
    }
}
