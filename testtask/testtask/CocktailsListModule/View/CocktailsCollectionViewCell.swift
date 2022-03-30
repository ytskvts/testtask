//
//  CocktailsCollectionViewCell.swift
//  testtask
//
//  Created by Dmitry on 29.03.22.
//

import UIKit

class CocktailsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CocktailsCollectionViewCell"
    
    private let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.layoutIfNeeded()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let gradientView: GradientView = {
        let view = GradientView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gradientView.alpha = 0
        contentView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        gradientView.layer.frame = bounds
        contentView.clipsToBounds = true
    }
    
    func setUIElement() {
        contentView.addSubview(cocktailNameLabel)
        cocktailNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
        contentView.insertSubview(gradientView, at: 0)
    }
    
    func configure(with data: CocktailCollectionCellModel) {
        cocktailNameLabel.text = data.name
        if data.isSearchable || data.isSelect {
            gradientView.alpha = 1
        } else {
            contentView.backgroundColor = .systemGray
        }
    }
}
