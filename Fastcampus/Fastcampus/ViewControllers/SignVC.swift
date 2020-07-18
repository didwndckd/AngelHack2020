//
//  SignVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SignVC: ViewController<SignView> {
  
  func signIn(emailTextField: UITextField, passwordTextField: UITextField) {
    guard let email = emailTextField.text, !email.isEmpty else {
      alertNormal(title: "이메일을 입력해 주세요") { _ in
        emailTextField.becomeFirstResponder()
      }
      return
    }
    
    guard let password = passwordTextField.text, !password.isEmpty else {
      alertNormal(title: "비밀번호를 입력해 주세요") { _ in
        passwordTextField.becomeFirstResponder()
      }
      return
    }
    
    presentIndicatorViewController()
    SignService.signIn(email: email, password: password) {
      self.dismissIndicatorViewController()
      WindowManager.set(.main)
    }
  }
}
