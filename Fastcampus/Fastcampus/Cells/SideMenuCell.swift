//
//  SideMenuCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
  private lazy var leftStackView = UIStackView(arrangedSubviews: [titleLabel])
  private let titleLabel = UILabel()
  private let enterImageView = UIImageView()
  private let progressBar = UIProgressView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setProperties(at index: Int, title: String) {
    if index == 0 {
      leftStackView.addArrangedSubview(progressBar)
    }
    titleLabel.text = title
  }
  
  private func attribute() {
    leftStackView.axis = .vertical
    leftStackView.alignment = .fill
    leftStackView.distribution = .fill
    leftStackView.spacing = 8
    
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    
    progressBar.setProgress(0.8, animated: true)
    progressBar.tintColor = .darkGray
    
    enterImageView.image = #imageLiteral(resourceName: "icon_enter_black")
    enterImageView.contentMode = .scaleAspectFit
    enterImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [leftStackView, enterImageView]
      .forEach { contentView.addSubview($0) }
    
    leftStackView.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(contentView).offset(margins * 2)
      $0.trailing.equalTo(enterImageView.snp.leading).offset(-margins * 2)
    }
    
    enterImageView.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView).offset(-margins * 2)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
