//
//  SideMenuCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MypageCell: UITableViewCell {
  private lazy var leftStackView = UIStackView(arrangedSubviews: [titleLabel])
  private let titleLabel = UILabel()
  private let enterImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setProperties(title: String) {
    titleLabel.text = title
  }
  
  private func attribute() {
    leftStackView.axis = .vertical
    leftStackView.alignment = .fill
    leftStackView.distribution = .fill
    leftStackView.spacing = 8
    
    titleLabel.textColor = #colorLiteral(red: 0.3583612144, green: 0.3541941345, blue: 0.3540837169, alpha: 1)
    titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    enterImageView.image = #imageLiteral(resourceName: "icon_enter_black")
    enterImageView.contentMode = .scaleAspectFit
    enterImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [titleLabel, enterImageView]
      .forEach { contentView.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margins / 3)
      $0.leading.equalTo(contentView).offset(margins * 2)
      $0.trailing.equalTo(enterImageView.snp.leading).offset(-margins * 2)
      $0.bottom.equalTo(contentView).offset(-margins / 3)
    }
    
    enterImageView.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView).offset(-margins * 2)
      $0.width.height.equalTo(30)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class MypageTitleCell: UITableViewCell {
  private let titleLabel = UILabel()
  private let separatorView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setTitle(text: String) {
    titleLabel.text = text
  }
  
  private func attribute() {
    titleLabel.textColor = .darkGray
    titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
    
    separatorView.backgroundColor = .lightGray
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [titleLabel, separatorView]
      .forEach { contentView.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margins)
      $0.leading.equalTo(contentView).offset(margins * 2)
    }
    
    separatorView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(contentView).offset(margins * 2)
      $0.trailing.equalTo(contentView).offset(-margins * 2)
      $0.bottom.equalTo(contentView).offset(-margins / 2)
      $0.height.equalTo(1)
    }
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
