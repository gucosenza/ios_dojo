//
//  AppDelegate.swift
//  picpay
//
//  Created by gustavo.cosenza on 19/06/19.
//  Copyright © 2019 gustavo.cosenza. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = UsersViewController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }

}

