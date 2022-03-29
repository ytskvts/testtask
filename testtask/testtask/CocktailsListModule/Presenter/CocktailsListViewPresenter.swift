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
    
    var cocktails: [CoctailCollectionCellModel] = [] {
        didSet {
            view?.printData(data: cocktails)
            //self.collectionView.reloadData()
        }
    }
    
    
    
    
    
    
    func fetchData() {
        NetworkManager.shared.fetchData(type: Cocktails.self) { result in
            switch result {
            case .success(let cocktailsData):
                //better add parser
                self.cocktails = cocktailsData.cocktailsList.compactMap({
                    print("-")
                    return CoctailCollectionCellModel(name: $0.name, isSelect: false)
                })
                //self.cocktails = cocktailsData.cocktailsList
            case .failure(let error):
                print(error)
            }
        }
    }
}
