//
//  LectureStartCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class LectureStartCell: UITableViewCell {
  static let identifier = "LectureStartCell"
  private let levelButton = UIButton()
  private let nameLabel = UILabel()
  private let titleLabel = UILabel()
  private let startDateBgView = UIView()
  private let startDateLabel = UILabel()
  private let peopleLabel = UILabel()
  private let joinButton = UIButton()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func makeGradientJoinButton() {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [
      UIColor(red: 204/255, green: 35/255, blue: 69/255, alpha: 1).cgColor,
      UIColor(red: 253/255, green: 113/255, blue: 80/255, alpha: 1).cgColor
    ]
    gradient.locations = [0.0, 1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = CGRect(x: 0, y: 0, width: 80, height: 34)
    joinButton.layer.insertSublayer(gradient, at: 0)
    joinButton.layer.cornerRadius = 8
    joinButton.clipsToBounds = true
  }
  
  private func attribute() {
    levelButton.setTitle("Lv.9", for: .normal)
    levelButton.setTitleColor(.red, for: .normal)
    levelButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    levelButton.layer.borderColor = UIColor.red.cgColor
    levelButton.layer.borderWidth = 1
    levelButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
    
    nameLabel.text = "김예은"
    nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    titleLabel.text = "1회차 같이 완주해요!"
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
    
    startDateBgView.backgroundColor = #colorLiteral(red: 1, green: 0.9131416678, blue: 0.8906806111, alpha: 1)
    
    startDateLabel.text = "07.14 16:00 시작"
    startDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    peopleLabel.text = "3명 / 6명"
    peopleLabel.textColor = #colorLiteral(red: 0.5988813043, green: 0.5989002585, blue: 0.6190659404, alpha: 1)
    peopleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    joinButton.setTitle("참여하기", for: .normal)
    joinButton.setTitleColor(.white, for: .normal)
    joinButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    joinButton.layer.cornerRadius = 14
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [levelButton, nameLabel, titleLabel, startDateBgView, startDateLabel, peopleLabel, joinButton]
      .forEach { contentView.addSubview($0) }
    
    levelButton.snp.makeConstraints {
      $0.top.leading.equalTo(contentView).offset(margins)
    }
    
    nameLabel.snp.makeConstraints {
      $0.centerY.equalTo(levelButton)
      $0.leading.equalTo(levelButton.snp.trailing).offset(margins / 3)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(levelButton.snp.bottom).offset(margins / 3)
      $0.leading.equalTo(contentView).offset(margins)
    }
    
    startDateLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(contentView).offset(margins + 3)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    startDateBgView.snp.makeConstraints {
      $0.top.leading.equalTo(startDateLabel).offset(-3)
      $0.trailing.bottom.equalTo(startDateLabel).offset(3)
    }
    
    peopleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(startDateBgView.snp.trailing).offset(margins / 2)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    joinButton.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView).offset(-margins)
      $0.width.equalTo(80)
      $0.height.equalTo(34)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
