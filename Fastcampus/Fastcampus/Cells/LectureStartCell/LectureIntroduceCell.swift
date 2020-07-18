//
//  LectureIntroduceCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class LectureIntroduceCell: UITableViewCell {
  static let identifier = "LectureIntroduceCell"
  private let titleBgView = UIView()
  private let titleLabel = UILabel()
  private let contentsLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  private func attribute() {
    titleBgView.layer.cornerRadius = 8
    
    titleLabel.text = "UX/UI 디자인 올인원 패키지 Online."
    titleLabel.textColor = .white
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byCharWrapping
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [titleBgView, titleLabel, contentsLabel]
      .forEach { contentView.addSubview($0) }
    
    titleBgView.snp.makeConstraints {
      $0.centerX.equalTo(contentView)
      $0.top.leading.equalTo(contentView).offset(margins)
      $0.leading.equalTo(contentView).offset(margins)
      $0.trailing.equalTo(contentView).offset(-margins)
      $0.height.equalTo(43)
    }
    
    titleLabel.snp.makeConstraints {
      $0.center.equalTo(titleBgView)
      $0.leading.equalTo(titleBgView).offset(margins)
      $0.trailing.equalTo(titleBgView).offset(-margins)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins)
      $0.leading.equalTo(titleBgView).offset(margins)
      $0.trailing.equalTo(titleBgView).offset(-margins)
      $0.bottom.equalTo(contentView)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    titleBgView.makeGradient()
  }
}
