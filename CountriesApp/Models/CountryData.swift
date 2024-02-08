//
//  CountryData.swift
//  CountriesApp
//
//  Created by Guy Twig on 08/02/2024.
//

import Foundation

class CountryData: Codable {
    let name: NameDetails?
    let region: String?
    let subregion: String?
    let flag: String?
    var saved: Bool?
    
    init(name: NameDetails?, region: String?, subregion: String?, flag: String?, saved: Bool? = false) {
        self.name = name
        self.region = region
        self.subregion = subregion
        self.flag = flag
        self.saved = saved
    }
}

class NameDetails: Codable {
    let common: String?

    init(common: String?) {
        self.common = common
    }
}
