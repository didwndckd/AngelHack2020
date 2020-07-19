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
        return MainTabBarVC()
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
