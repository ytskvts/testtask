//
//  Constant.swift
//  testtask
//
//  Created by Dmitry on 30.03.22.
//

import Foundation
import UIKit

struct Constants {
    struct URLString {
        static let defaultURLString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    }
    
    struct Color {
        static let redColor: UIColor = #colorLiteral(red: 0.9977816939, green: 0.3210689425, blue: 0.3865003586, alpha: 1)
        static let purpleColor: UIColor = #colorLiteral(red: 0.9875181317, green: 0.3365618885, blue: 0.9982401729, alpha: 1)
    }
    
    struct Spacing {
        static let interItemSpacing: CGFloat = 8.0
        static let interGroupSpacing: CGFloat = 8.0
    }
}
