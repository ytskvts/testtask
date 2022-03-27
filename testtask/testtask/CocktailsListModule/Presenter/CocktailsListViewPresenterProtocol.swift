//
//  CocktailsListViewPresenterProtocol.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation

protocol CocktailsListViewPresenterProtocol {
    
    var cocktails: [Cocktail] { get set }
    
    func fetchData()
}
