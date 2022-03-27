//
//  CoctailModel.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation

struct Cocktail: Codable {
  let cocktailName: String?
}

struct Cocktails: Codable {
    let cocktails: [Cocktail]
}
