//
//  UserDefaultExtension.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import Foundation

extension UserDefaults {
    enum UserDefaultsKeys: String {
        case favListSave
        case savedCountries
    }
    
    var savedCountries: [CountryData]? {
        get {
            if let data = object(forKey: UserDefaultsKeys.savedCountries.rawValue) as? Data {
                let countryList = try? JSONDecoder().decode([CountryData].self, from: data)
                return countryList
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            setValue(data, forKey: UserDefaultsKeys.savedCountries.rawValue)
        }
    }
}
