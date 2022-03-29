//
//  ViewController.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import UIKit
import SnapKit

class CocktailsListViewController: UIViewController, CocktailsListViewProtocol {

    var cocktailsListViewPresenter: CocktailsListViewPresenterProtocol?
        
    init() {
        super.init(nibName: nil, bundle: nil)
        cocktailsListViewPresenter = CocktailsListViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cocktailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGreen
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let searchingTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Cocktail name"
        textField.autocapitalizationType = .words
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0.5942070484, blue: 0.9925900102, alpha: 1)
        
        textField.autocorrectionType = .no
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailsCollectionView.dataSource = self
        cocktailsCollectionView.delegate = self
        cocktailsListViewPresenter?.fetchData()
        view.backgroundColor = .systemRed
        setUIElements()
    }
    
    func printData(data: [CocktailCollectionCellModel]) {
        print(data)
    }
    
    func setUIElements() {
        view.addSubview(cocktailsCollectionView)
        view.addSubview(searchingTextField)
        searchingTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
            make.height.equalTo(40)
        }
        cocktailsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            //make.top.equalToSuperview().inset(5)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
            make.bottom.equalTo(searchingTextField.snp.top).inset(-20)
        }
    }

}

extension CocktailsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let quantity = cocktailsListViewPresenter?.getAmountOfItemsInSection(in: section) {
            return quantity
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = cocktailsCollectionView.dequeueReusableCell(withReuseIdentifier: "CocktailsCollectionViewCell", for: indexPath) as? CocktailsCollectionViewCell,
           let data = cocktailsListViewPresenter?.getCocktail(forItemAt: indexPath) {
            cell.configure(with: data)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter = cocktailsListViewPresenter else {
            fatalError("collectionView didSelectItemAt method: presenter is nil")
        }
        presenter.didSelectItem(at: indexPath)
    }
    
}
