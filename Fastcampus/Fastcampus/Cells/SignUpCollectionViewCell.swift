//
//  SignUpCollectionViewCell.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SignUpCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "SignUpCollectionViewCell"
  
  private let displayLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUI() {
    displayLabel.text = "프로토타입에서는 지원하지 않습니다"
    displayLabel.font = .boldSystemFont(ofSize: 20)
    displayLabel.textColor = .darkGray
  }
  
  private struct Standard {
    static let space: CGFloat = 8
  }
  
  private func setConstraint() {
    contentView.addSubview(displayLabel)
    displayLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      displayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      displayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
    ])
  }
}
