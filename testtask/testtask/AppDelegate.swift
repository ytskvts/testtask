//
//  AppDelegate.swift
//  testtask
//
//  Created by Dmitry on 27.03.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CocktailsListViewController()
        window?.makeKeyAndVisible()
        return true
    }


}

