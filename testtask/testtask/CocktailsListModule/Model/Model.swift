//
//  CoctailModel.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation

struct Cocktail: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
    }
}

struct Cocktails: Codable {
    let cocktailsList: [Cocktail]
    
    enum CodingKeys: String, CodingKey {
        case cocktailsList = "drinks"
    }
}
