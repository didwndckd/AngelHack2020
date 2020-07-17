//
//  SignView.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SignView: View {
  
  private let signInPageButton = UIButton()
  private let signUpPageButton = UIButton()
  
  private let pageBaseView = UIView()
  private let currentPageView = UIView()
  
  private var leadingConstraint: NSLayoutConstraint?
  
  private let pageCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    super.attribute()
    
    signInPageButton.setTitle("  로그인", for: .normal)
    signInPageButton.isSelected = true
    signUpPageButton.setTitle("  회원가입", for: .normal)
    [signInPageButton, signUpPageButton].forEach {
      $0.setTitleColor(.myRed, for: .selected)
      $0.setTitleColor(.black, for: .normal)
      $0.titleLabel?.font = .boldSystemFont(ofSize: 17)
      $0.contentHorizontalAlignment = .left
      $0.addTarget(self, action: #selector(pageButtonDidTap(_:)), for: .touchUpInside)
    }
    
    pageBaseView.backgroundColor = .myGray
    currentPageView.backgroundColor = .myRed
    [pageBaseView, currentPageView].forEach {
      $0.layer.cornerRadius = 1
    }
    
    pageCollectionView.isScrollEnabled = false
    pageCollectionView.backgroundColor = .white
    pageCollectionView.register(SignInCollectionViewCell.self, forCellWithReuseIdentifier: SignInCollectionViewCell.identifier)
    pageCollectionView.register(SignUpCollectionViewCell.self, forCellWithReuseIdentifier: SignUpCollectionViewCell.identifier)
    pageCollectionView.dataSource = self
    pageCollectionView.delegate = self
  }
  
  override func setupUI() {
    super.setupUI()
    
    let guide = self.safeAreaLayoutGuide
    let xSpace: CGFloat = 24
    
    [signInPageButton, signUpPageButton,
     pageBaseView, currentPageView,
     pageCollectionView].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      signInPageButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
      signInPageButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: xSpace),
      
      signUpPageButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 24),
      signUpPageButton.leadingAnchor.constraint(equalTo: signInPageButton.trailingAnchor),
      signUpPageButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -xSpace),
      signUpPageButton.widthAnchor.constraint(equalTo: signInPageButton.widthAnchor),
      
      
      
      pageBaseView.topAnchor.constraint(equalTo: signInPageButton.bottomAnchor),
      pageBaseView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: xSpace),
      pageBaseView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -xSpace),
      pageBaseView.heightAnchor.constraint(equalToConstant: 2),
      
      currentPageView.topAnchor.constraint(equalTo: pageBaseView.topAnchor),
      currentPageView.widthAnchor.constraint(equalTo: pageBaseView.widthAnchor, multiplier: 0.5),
      currentPageView.heightAnchor.constraint(equalToConstant: 2),
      
      
      
      pageCollectionView.topAnchor.constraint(equalTo: pageBaseView.bottomAnchor),
      pageCollectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      pageCollectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      pageCollectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
    ])
    
    let tempConstraint = currentPageView.leadingAnchor.constraint(equalTo: signInPageButton.leadingAnchor)
    tempConstraint.priority = .init(500)
    tempConstraint.isActive = true
    
    leadingConstraint = currentPageView.leadingAnchor.constraint(equalTo: signUpPageButton.leadingAnchor)
    leadingConstraint?.priority = .defaultLow
    leadingConstraint?.isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}



extension SignView {
  @objc private func pageButtonDidTap(_ sender: UIButton) {
    UIView.animate(withDuration: 0.3) {
      self.signInPageButton.isSelected = sender == self.signInPageButton
      self.signUpPageButton.isSelected = sender == self.signUpPageButton
      
      switch sender == self.signInPageButton {
      case true:
        self.leadingConstraint?.priority = .defaultLow
        
      case false:
        self.leadingConstraint?.priority = .defaultHigh
      }
      
      self.layoutIfNeeded()
    }
    
    let xPoint: CGFloat = sender == self.signInPageButton ? 0 : self.frame.width
    pageCollectionView.setContentOffset(CGPoint(x: xPoint, y: 0), animated: true)
  }
}




extension SignView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 2 }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.row {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignInCollectionViewCell.identifier, for: indexPath)
      return cell
      
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignUpCollectionViewCell.identifier, for: indexPath)
      return cell
    }
  }
}



extension SignView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    collectionView.frame.size
  }
}
