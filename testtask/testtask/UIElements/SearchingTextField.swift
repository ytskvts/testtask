//
//  SearchingTextField.swift
//  testtask
//
//  Created by Dmitry on 30.03.22.
//

import UIKit

class SearchingTextField: UITextField {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupStyle()
    }
    
    func setupStyle() {
        self.textAlignment = .center
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 9
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 5.0, height: 8.0)
        self.autocorrectionType = .no
    }
}
