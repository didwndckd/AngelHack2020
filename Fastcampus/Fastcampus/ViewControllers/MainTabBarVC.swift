//
//  MainTabBarVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let studyListVC = UINavigationController(rootViewController: StudyListVC())
    let mainVC = UINavigationController(rootViewController: MainVC())
    let mypageVC = UINavigationController(rootViewController: MypageVC())
    
    studyListVC.tabBarItem = UITabBarItem(title: "참여중인 스터디", image: UIImage(named: "tab0_non"), selectedImage: UIImage(named: "tab0"))
    mainVC.tabBarItem = UITabBarItem(title: "나의 강의", image: UIImage(named: "tab1_non"), selectedImage: UIImage(named: "tab1"))
    mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "tab2_non"), selectedImage: UIImage(named: "tab2"))
    
    viewControllers = [studyListVC, mainVC, mypageVC]
    
    selectedIndex = 1
  }
}
