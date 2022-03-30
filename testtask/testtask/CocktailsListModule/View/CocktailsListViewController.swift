//
//  ViewController.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import UIKit
import SnapKit

class CocktailsListViewController: UIViewController {

    var cocktailsListViewPresenter: CocktailsListViewPresenterProtocol?
        
    init() {
        super.init(nibName: nil, bundle: nil)
        cocktailsListViewPresenter = CocktailsListViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cocktailsCollectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.register(CocktailsCollectionViewCell.self, forCellWithReuseIdentifier: CocktailsCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let searchingTextField: UITextField = {
        let textField = SearchingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Cocktail name"
        //textField.autocapitalizationType = .words //all words uppercase
        textField.clipsToBounds = false
        return textField
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailsCollectionView.dataSource = self
        cocktailsCollectionView.delegate = self
        if let cocktailsListViewPresenter = cocktailsListViewPresenter {
            cocktailsListViewPresenter.fetchData()
        }
        view.backgroundColor = .systemBackground
        setUIElements()
        setNotifications()
        setGestureForDismissKeyboard()
    }
    
    //MARK: Setup
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
            make.bottom.equalTo(searchingTextField.snp.top).inset(-5)
        }
    }
    
    func setNotifications() {
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) {_ in
            self.textDidChange()
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            
            guard let keyboardNSValue = nc.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = self.view.convert(keyboardNSValue.cgRectValue, from: self.view.window)
            
            self.searchingTextField.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(keyboardFrame.height - self.view.safeAreaInsets.bottom)
                make.height.equalTo(40)
            }
            self.searchingTextField.layer.cornerRadius = 0
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            
            self.searchingTextField.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(50)
                make.right.equalToSuperview().inset(40)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(100)
                make.height.equalTo(40)
            }
            self.searchingTextField.layer.cornerRadius = 10
        }
    }
    
    func textDidChange() {
        if let presenter = cocktailsListViewPresenter,
           let text = searchingTextField.text {
            presenter.textDidChange(text: text)
            return
        }
        fatalError("CocktailsListViewController textDidChange method: presenter or text is optional")
    }
    
    private func setGestureForDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        searchingTextField.endEditing(true)
    }
    
    //MARK: Setup CollectionView
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(30.0), heightDimension: .absolute(30.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(Constants.Spacing.interItemSpacing)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = Constants.Spacing.interGroupSpacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CocktailsListViewController: CocktailsListViewProtocol {
    func reloadCollectionViewData(data: [CocktailCollectionCellModel]) {
        cocktailsCollectionView.reloadData()
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
    
    // when wrote "func sizef" than xcode has been droped
}
