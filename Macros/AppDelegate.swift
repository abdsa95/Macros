//
//  AppDelegate.swift
//  Macros
//
//  Created by Abdualziz Aljuaid on 01/06/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        return true
    }
}
