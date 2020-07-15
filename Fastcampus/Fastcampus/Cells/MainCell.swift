//
//  MainCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
  static let identifier = "MainCell"
  private let lectureContainerView = UIView()
  private let lectureImageView = UIImageView()
  private let textContainerView = UIView()
  private lazy var lectureStatusStackView = UIStackView(arrangedSubviews: [statusLabel, kindLabel])
  private let statusLabel = UILabel()
  private let kindLabel = UILabel()
  private let lectureTitleLabel = UILabel()
  private let lectureProgressBar = UIProgressView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setProperties(lecture: Lecture) {
    lectureTitleLabel.text = lecture.title
  }
  
  private func attribute() {
    lectureTitleLabel.text = "Mastering RxSwift"
    lectureTitleLabel.textColor = .white
    lectureTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
    
    lectureContainerView.layer.cornerRadius = 5
    lectureContainerView.clipsToBounds = true
    
    lectureImageView.backgroundColor = .blue
    
    textContainerView.backgroundColor = .blue
    textContainerView.alpha = 0.3
  }
  
  private func setupUI() {
    let margins: CGFloat = 10
    let sideMargins: CGFloat = 15
    
    contentView.addSubview(lectureContainerView)
    [lectureImageView, textContainerView, lectureStatusStackView, lectureTitleLabel, lectureProgressBar]
      .forEach { lectureContainerView.addSubview($0) }
    
    lectureContainerView.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margins)
      $0.leading.equalTo(contentView).offset(sideMargins)
      $0.trailing.equalTo(contentView).offset(-sideMargins)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    lectureImageView.snp.makeConstraints {
      $0.edges.equalTo(lectureContainerView)
    }
    
    textContainerView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalTo(lectureContainerView)
      $0.height.equalTo(lectureContainerView).multipliedBy(0.4)
    }
    
    lectureStatusStackView.snp.makeConstraints {
      
    }
    
    lectureTitleLabel.snp.makeConstraints {
      $0.leading.equalTo(textContainerView).offset(margins)
      $0.trailing.bottom.equalTo(textContainerView).offset(-margins)
    }
    
    lectureProgressBar.snp.makeConstraints {
      
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
