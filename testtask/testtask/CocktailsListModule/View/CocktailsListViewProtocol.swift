//
//  CocktailsListViewProtocol.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation

protocol CocktailsListViewProtocol: AnyObject {
    
    func reloadCollectionViewData(data: [CocktailCollectionCellModel])
}
