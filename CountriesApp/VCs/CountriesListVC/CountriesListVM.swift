//
//  CountriesListVM.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import Foundation
import Combine


protocol CountriesVMDelegate: AnyObject {
    func countriesFetched(countries: [CountryData]?, error: Error?)
}

class CountriesListVM {
    
    private var countryList: [CountryData] = []
    private var savedList: [CountryData] = []
    weak var delegate: CountriesVMDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCountries()
    }
    
    func fetchCountries() {
        countryList.removeAll()
        
        if let saved = UserDefaults.standard.savedCountries {
            countryList = saved
        }
        
        if let url = URL(string: "\(NetworkBuilder.ApiUrls.countriesBaseUrl.description)\(NetworkBuilder.EndPoints.querysCountries.description)") {
            let urlRequest = URLRequest(url: url)
            NetworkManager.shared.genericGetCall(url: urlRequest, type: [CountryData].self)
                .sink { [weak self]  completion in
                    guard let self else {
                        self?.delegate?.countriesFetched(countries: [], error: ErrorsHandlers.requestError(.invalidRequest(urlRequest)))
                        return
                    }
                    
                    if case .failure(let error) = completion {
                        print(ErrorsHandlers.requestError(.other(error)))
                        self.delegate?.countriesFetched(countries: [], error: ErrorsHandlers.requestError(.other(error)))
                    }
                } receiveValue: { [weak self] countryList in
                    guard let self else {
                        return
                    }
                    
                    let filteredCountryList = countryList.filter { country in
                        !self.countryList.contains { $0.name?.common == country.name?.common }
                    }
                    
                    self.countryList.append(contentsOf: filteredCountryList)
                    self.delegate?.countriesFetched(countries: self.countryList, error: nil)
                }
                .store(in: &cancellables)
        }
    }
}
