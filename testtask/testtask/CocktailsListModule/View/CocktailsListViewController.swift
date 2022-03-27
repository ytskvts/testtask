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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
    }

}

