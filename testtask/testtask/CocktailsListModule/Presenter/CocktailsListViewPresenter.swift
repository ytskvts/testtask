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
    
    var cocktails: [CocktailCollectionCellModel] = [] {
        didSet {
            view?.printData(data: cocktails) //self.collectionView.reloadData()
        }
    }
    
    
    
    
    
    
    func fetchData() {
        NetworkManager.shared.fetchData(type: Cocktails.self) { result in
            switch result {
            case .success(let cocktailsData):
                //better add parser
                self.cocktails = cocktailsData.cocktailsList.compactMap({
                    return CocktailCollectionCellModel(name: $0.name, isSelect: false)
                })
                //self.cocktails = cocktailsData.cocktailsList
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCocktail(forItemAt indexPath: IndexPath) -> CocktailCollectionCellModel {
        return cocktails[indexPath.row]
    }
    
    func getAmountOfItemsInSection(in section: Int) -> Int {
        return cocktails.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        cocktails[indexPath.row].isSelect = true
        //cocktails[indexPath.row].isSelect = true //if need to cancel gradient
    }
}
