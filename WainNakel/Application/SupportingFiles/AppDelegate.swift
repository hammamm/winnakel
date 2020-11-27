//
//  AppDelegate.swift
//  WainNakel
//
//  Created by hammam abdulaziz on 12/04/1442 AH.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MapView())
        window?.makeKeyAndVisible()
        
        return true
    }

}

