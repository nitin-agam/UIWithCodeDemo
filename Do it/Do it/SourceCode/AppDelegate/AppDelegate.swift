//
//  AppDelegate.swift
//  Do it
//
//  Created by Nitin A on 28/10/18.
//  Copyright © 2018 Nitin Aggarwal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = DemoListController()
        let navigation = UINavigationController(rootViewController: controller)
        
        // to remove shadow line below to navigation bar
        navigation.navigationBar.shadowImage = UIImage()
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        return true
    }
}

