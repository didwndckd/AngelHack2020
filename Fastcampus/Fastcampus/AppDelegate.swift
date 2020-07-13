//
//  AppDelegate.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController(rootViewController: MainVC())
    navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.9263463616, green: 0.9208396077, blue: 0.9305793047, alpha: 1)
    navigationController.navigationBar.prefersLargeTitles = true
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }
}
