//
//  SplashVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

class SplashVC: UIViewController {
  
  private let logoImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    setConstraint()
    checkSign()
    getAllUser()
  }
}



// MARK: - UI

extension SplashVC {
  private func setUI() {
    view.backgroundColor = .systemBackground
    logoImageView.image = UIImage(named: "Logo")
    view.addSubview(logoImageView)
  }
  
  private func getAllUser() {
    UserService.getAllUser()
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
      logoImageView.bottomAnchor.constraint(equalTo: guide.centerYAnchor)
    ])
  }
}



// MARK: - Sign

extension SplashVC {
  private func checkSign() {
    switch UserDefaults.standard.string(forKey: "email") == nil {
    case true:
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        WindowManager.set(.sign)
      }
      
    case false:
      guard
        let email = UserDefaults.standard.string(forKey: "email"),
        let password = UserDefaults.standard.string(forKey: "password")
        else { return }
      
      SignService.signIn(email: email, password: password) { result in
        switch result {
        case true:
          WindowManager.set(.main)
          
        case false:
          self.alertNormal(title: "잠시 후 다시 시도해주세요")
        }
      }
    }
  }
}


