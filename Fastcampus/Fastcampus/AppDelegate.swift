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
    let mainVC = MainVC()
    let sampleVC = SampleVC()
    let mypageVC = MypageVC()
    mainVC.tabBarItem = UITabBarItem(title: "참여중인 스터디", image: #imageLiteral(resourceName: "icon_lecture_deselected"), selectedImage: #imageLiteral(resourceName: "icon_lecture_selected"))
    sampleVC.tabBarItem = UITabBarItem(title: "나의 강의", image: #imageLiteral(resourceName: "icon_lecture_deselected"), selectedImage: #imageLiteral(resourceName: "icon_lecture_selected"))
    mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: #imageLiteral(resourceName: "icon_mypage_selected"), selectedImage: #imageLiteral(resourceName: "icon_mypage_selected"))
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [mainVC, sampleVC, mypageVC]
    let navigationController = UINavigationController(rootViewController: tabBarController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }
}
