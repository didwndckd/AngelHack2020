//
//  MainCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Kingfisher

class MainCell: UITableViewCell {
  static let identifier = "MainCell"
  private let lectureContainerView = UIView()
  private let lectureImageView = UIImageView()
  private let textContainerView = UIView()
  private let enterImageView = UIImageView()
  private lazy var lectureStatusStackView = UIStackView(arrangedSubviews: [statusLabel, kindLabel])
  private let statusLabel = UIButton()
  private let kindLabel = UIButton()
  private let lectureTitleLabel = UILabel()
  private let lectureProgressBar = UIProgressView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setGradientBackground() {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [UIColor.black.cgColor, UIColor.lightGray.cgColor]
    gradient.locations = [0.0, 1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height * 0.4)
    self.textContainerView.layer.insertSublayer(gradient, at: 0)
  }
  
  func setProperties(lecture: Lecture) {
    if let url = URL(string: lecture.imageURL) {
      lectureImageView.kf.setImage(with: url)
    }
    
    lectureTitleLabel.text = lecture.title
    kindLabel.setTitle("\(lecture.type)강의", for: .normal)
  }
  
  private func attribute() {
    lectureContainerView.layer.cornerRadius = 5
    lectureContainerView.clipsToBounds = true
    lectureImageView.backgroundColor = #colorLiteral(red: 0.8062266707, green: 0.8064672351, blue: 0.8251868486, alpha: 1)

    textContainerView.alpha = 0.3
    
    lectureImageView.contentMode = .scaleToFill
        
    enterImageView.image = #imageLiteral(resourceName: "icon_enter_white")
    
    lectureStatusStackView.axis = .horizontal
    lectureStatusStackView.alignment = .fill
    lectureStatusStackView.distribution = .fill
    lectureStatusStackView.spacing = 5
    
    statusLabel.setTitle("수강중", for: .normal)
    [statusLabel, kindLabel].forEach {
      let titleColor = $0 == statusLabel ? UIColor.black : UIColor.white
      $0.setTitleColor(titleColor, for: .normal)
      let backgroundColor = $0 == statusLabel ? UIColor.white : UIColor.clear
      $0.backgroundColor = backgroundColor
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.white.cgColor
      $0.isUserInteractionEnabled = false
      $0.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
    
    lectureTitleLabel.text = "Mastering RxSwift"
    lectureTitleLabel.textColor = .white
    lectureTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    
    lectureProgressBar.backgroundColor = .white
    lectureProgressBar.layer.cornerRadius = 1
  }
  
  private func setupUI() {
    let margins: CGFloat = 10
    
    [lectureContainerView, enterImageView]
      .forEach { contentView.addSubview($0) }
    
    [lectureImageView, textContainerView, lectureStatusStackView, lectureTitleLabel, lectureProgressBar]
      .forEach { lectureContainerView.addSubview($0) }
    
    lectureContainerView.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margins)
      $0.leading.trailing.equalTo(contentView)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    lectureImageView.snp.makeConstraints {
      $0.edges.equalTo(lectureContainerView)
    }
    
    textContainerView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalTo(lectureContainerView)
      $0.height.equalTo(lectureContainerView).multipliedBy(0.4)
    }
    
    enterImageView.snp.makeConstraints {
      $0.centerY.equalTo(lectureImageView)
      $0.trailing.equalTo(lectureImageView).offset(-margins)
    }
    
    lectureStatusStackView.snp.makeConstraints {
      $0.leading.equalTo(textContainerView).offset(margins)
      $0.bottom.equalTo(lectureTitleLabel.snp.top).offset(-margins / 2)
    }
    
    lectureTitleLabel.snp.makeConstraints {
      $0.leading.equalTo(textContainerView).offset(margins)
      $0.trailing.equalTo(textContainerView).offset(-margins)
      $0.bottom.equalTo(lectureProgressBar.snp.top).offset(-margins)
    }
    
    lectureProgressBar.snp.makeConstraints {
      $0.leading.equalTo(textContainerView).offset(margins)
      $0.trailing.bottom.equalTo(textContainerView).offset(-margins)
      $0.height.equalTo(3)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
