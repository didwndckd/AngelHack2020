//
//  WindowManager.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

final class WindowManager {
  enum VisibleViewControllerType {
    case splash
    case sign
    case main
    
    var controller: UIViewController {
      switch self {
      case .splash:
        return SplashVC()
        
      case .sign:
        return SignVC()
        
      case .main:
        let mainVC = MainVC()
        let studyListVC = StudyListVC()
        let mypageVC = MypageVC()
        mainVC.tabBarItem = UITabBarItem(title: "참여중인 스터디", image: #imageLiteral(resourceName: "icon_lecture_deselected"), selectedImage: #imageLiteral(resourceName: "icon_lecture_selected"))
        studyListVC.tabBarItem = UITabBarItem(title: "나의 강의", image: #imageLiteral(resourceName: "icon_lecture_deselected"), selectedImage: #imageLiteral(resourceName: "icon_lecture_selected"))
        mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: #imageLiteral(resourceName: "icon_mypage_selected"), selectedImage: #imageLiteral(resourceName: "icon_mypage_selected"))
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC, studyListVC, mypageVC]
        return UINavigationController(rootViewController: tabBarController)
      }
    }
  }
  
  class func set(_ type: VisibleViewControllerType) {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.rootViewController = type.controller
    window.makeKeyAndVisible()
    
    delegate.window = window
  }
}
import Foundation
