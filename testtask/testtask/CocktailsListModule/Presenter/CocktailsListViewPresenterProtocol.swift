//
//  CocktailsListViewPresenterProtocol.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation

protocol CocktailsListViewPresenterProtocol {
    
    var cocktails: [CocktailCollectionCellModel] { get set }
    
    func fetchData()
    
    func textDidChange(text: String)
    
    //collection
    
    func getCocktail(forItemAt indexPath: IndexPath) -> CocktailCollectionCellModel
    
    func getAmountOfItemsInSection(in section: Int) -> Int
    
    func didSelectItem(at indexPath: IndexPath)
    
    
    
}
