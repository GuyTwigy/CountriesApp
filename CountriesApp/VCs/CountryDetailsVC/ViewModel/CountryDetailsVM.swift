//
//  CountryDetailsVM.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import Foundation

class CountryDetailsVM {
    
    init(country: CountryData) {
        addCountry(newCountry: country)
    }
            
    func addCountry(newCountry: CountryData) {
        var countryToAdd: CountryData
        countryToAdd = newCountry
        countryToAdd.saved = true
        
        var newSavedContries: [CountryData] = []
        if let saved = UserDefaults.standard.savedCountries {
            newSavedContries = saved
        }
        
        if !newSavedContries.contains(where: { $0.name?.common == countryToAdd.name?.common }) {
            newSavedContries.append(countryToAdd)
            UserDefaults.standard.savedCountries = newSavedContries
            CountriesManager.shared.lastDetailed = countryToAdd
            print("\(countryToAdd.name?.common ?? "") added succesfuly to saved list")
        }
    }
}
