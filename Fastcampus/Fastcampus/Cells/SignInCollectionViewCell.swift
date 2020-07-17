//
//  SignInCollectionViewCell.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SignInCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "SignInCollectionViewCell"
  
  private var isAuto = false
  
  private let emailDisplayLabel = UILabel()
  private let emailTextField = UITextField()
  private let passwordDisplayLabel = UILabel()
  private let passwordTextField = UITextField()
  
  private let autoSignInImage = UILabel()
  private let autoSignInButton = UIButton()
  private let resetPasswordButton = UIButton()
  
  private let signInButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUI() {
    emailDisplayLabel.text = "이메일"
    emailDisplayLabel.font = .boldSystemFont(ofSize: 18)
    emailTextField.placeholder = "이메일 주소를 입력해 주세요"
    emailTextField.keyboardType = .emailAddress
    
    passwordDisplayLabel.text = "비밀번호"
    passwordDisplayLabel.font = .boldSystemFont(ofSize: 18)
    passwordTextField.placeholder = "비밀번호를 입력해 주세요"
    passwordTextField.isSecureTextEntry = true
    
    [emailTextField, passwordTextField].forEach {
      $0.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 48)))
      $0.leftViewMode = .always
      $0.rightView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 48)))
      $0.rightViewMode = .always
      $0.layer.borderColor = UIColor.myGray.cgColor
      $0.layer.borderWidth = 2
      $0.delegate = self
    }
    
    autoSignInImage.backgroundColor = .myGray
    autoSignInImage.text = "✓"
    autoSignInImage.textColor = .white
    autoSignInImage.textAlignment = .center
    autoSignInImage.font = .boldSystemFont(ofSize: 16)
    autoSignInImage.layer.cornerRadius = 20 / 2
    autoSignInImage.layer.masksToBounds = true
    autoSignInButton.setTitle("자동 로그인 하기", for: .normal)
    autoSignInButton.setTitleColor(.black, for: .normal)
    autoSignInButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    autoSignInButton.addTarget(self, action: #selector(autoSignButtonDidTap(_:)), for: .touchUpInside)
    
    resetPasswordButton.setTitle("비밀번호 찾기", for: .normal)
    resetPasswordButton.setTitleColor(.gray, for: .normal)
    resetPasswordButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    
    signInButton.setTitle("로그인하기", for: .normal)
    signInButton.backgroundColor = .gray
    signInButton.addTarget(self, action: #selector(signInButtonDidTap), for: .touchUpInside)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
  }
  
  private func setConstraint() {
    let xSpace: CGFloat = 24
    let ySpace: CGFloat = 16
    let toSpace: CGFloat = 8
    
    [emailDisplayLabel, emailTextField,
     passwordDisplayLabel, passwordTextField,
     autoSignInImage, autoSignInButton, resetPasswordButton,
     signInButton].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      emailDisplayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
      emailDisplayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpace),
      
      emailTextField.topAnchor.constraint(equalTo: emailDisplayLabel.bottomAnchor, constant: toSpace),
      emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpace),
      emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xSpace),
      emailTextField.heightAnchor.constraint(equalToConstant: 48),
      
      
      
      passwordDisplayLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ySpace),
      passwordDisplayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpace),
      
      passwordTextField.topAnchor.constraint(equalTo: passwordDisplayLabel.bottomAnchor, constant: toSpace),
      passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpace),
      passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xSpace),
      passwordTextField.heightAnchor.constraint(equalToConstant: 48),
      
      
      
      autoSignInImage.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
      autoSignInImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpace),
      autoSignInImage.widthAnchor.constraint(equalToConstant: 20),
      autoSignInImage.heightAnchor.constraint(equalToConstant: 20),
      
      autoSignInButton.centerYAnchor.constraint(equalTo: autoSignInImage.centerYAnchor),
      autoSignInButton.leadingAnchor.constraint(equalTo: autoSignInImage.trailingAnchor, constant: toSpace),
      
      resetPasswordButton.centerYAnchor.constraint(equalTo: autoSignInImage.centerYAnchor),
      resetPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xSpace),
      
      
      
      signInButton.topAnchor.constraint(equalTo: autoSignInImage.bottomAnchor, constant: 32),
      signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xSpace),
      signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xSpace),
      signInButton.heightAnchor.constraint(equalToConstant: 48)
    ])
  }
}



extension SignInCollectionViewCell: UITextFieldDelegate {
  @objc private func autoSignButtonDidTap(_ sender: UIButton) {
    isAuto.toggle()
    autoSignInImage.backgroundColor = isAuto ? .myRed : .myGray
  }
  
  @objc private func signInButtonDidTap() {
    guard let vc = self.parentViewController as? SignVC else { return }
    vc.signIn(emailTextField: emailTextField, passwordTextField: passwordTextField)
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case emailTextField:
      passwordTextField.becomeFirstResponder()
      
    default:
      passwordTextField.resignFirstResponder()
    }
    
    return true
  }
}

