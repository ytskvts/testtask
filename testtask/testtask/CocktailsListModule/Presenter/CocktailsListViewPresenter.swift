//
//  CocktailsListViewPresenter.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import Foundation

class CocktailsListViewPresenter: CocktailsListViewPresenterProtocol {
    
    weak var view: CocktailsListViewProtocol?
    
    init(view: CocktailsListViewProtocol) {
        self.view = view
    }
    
    var cocktails = [Cocktail]()
    
    
    
    
    
    
    func fetchData() {
        NetworkManager.shared.fetchData(type: Cocktails.self) { result in
            switch result {
            case .success(let cocktailsData):
                self.cocktails = cocktailsData.cocktails
                //self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
