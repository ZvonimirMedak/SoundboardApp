//
//  AppDelegate.swift
//  SoundboardApp
//
//  Created by Zvonimir Medak on 22.05.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {return false}
        window.makeKeyAndVisible()
        window.rootViewController = HomeViewController(viewModel: HomeViewModel())
        return true
    }


}

