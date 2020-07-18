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
  private let contentsLabel = UITextView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setProperties(title: String, description: String) {
    titleLabel.text = title
    contentsLabel.text = description
  }
  
  func updateHeight(height: CGFloat) {
    let margins: CGFloat = 15
    contentsLabel.snp.remakeConstraints {
      $0.top.equalTo(titleBgView.snp.bottom).offset(margins)
      $0.leading.equalTo(titleBgView).offset(margins / 2)
      $0.trailing.equalTo(titleBgView).offset(-margins / 2)
      $0.bottom.equalTo(contentView).offset(-margins)
      $0.height.equalTo(height).priority(999)
    }
    layoutIfNeeded()
  }
  
  private func attribute() {
    titleBgView.layer.cornerRadius = 8
    titleBgView.clipsToBounds = true
    
    titleLabel.text = "UX/UI 디자인 올인원 패키지 Online."
    titleLabel.textColor = .white
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byCharWrapping
    titleLabel.sizeToFit()
    titleLabel.adjustsFontSizeToFitWidth = true
    
    contentsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    contentsLabel.bounces = false
    contentsLabel.isEditable = false
    contentsLabel.text = """
    UX 디자인 사례 및 디자인이란 무엇인가?
    디자이너의 역할 : UI, UX, GUI, VD, IXD의 차이 학습
    UX 디자인 프로세스 학습
    UX 리서치 & 필드 리서치
    데이터 모델링 & 서비스 기획 학습
    데이터 드리븐 UX 및 심리학 / 행동 경제학 UX 디자인 사례 및 디자인이란 무엇인가?
    디자이너의 역할 : UI, UX, GUI, VD, IXD의 차이 학습
    UX 디자인 프로세스 학습
    UX 리서치 & 필드 리서치
    데이터 모델링 & 서비스 기획 학습
    데이터 드리븐 UX 및 심리학 / 행동 경제학
    
    UX 디자인 사례 및 디자인이란 무엇인가?
    디자이너의 역할 : UI, UX, GUI, VD, IXD의 차이 학습
    UX 디자인 프로세스 학습
    UX 리서치 & 필드 리서치
    데이터 모델링 & 서비스 기획 학습
    데이터 드리븐 UX 및 심리학 / 행동 경제학 UX 디자인 사례 및 디자인이란 무엇인가?
    디자이너의 역할 : UI, UX, GUI, VD, IXD의 차이 학습
    UX 디자인 프로세스 학습
    UX 리서치 & 필드 리서치
    데이터 모델링 & 서비스 기획 학습
    데이터 드리븐 UX 및 심리학 / 행동 경제학
    
    UX 디자인 사례 및 디자인이란 무엇인가?
    디자이너의 역할 : UI, UX, GUI, VD, IXD의 차이 학습
    UX 디자인 프로세스 학습
    UX 리서치 & 필드 리서치
    데이터 모델링 & 서비스 기획 학습
    데이터 드리븐 UX 및 심리학 / 행동 경제학 UX 디자인 사례 및 디자인이란 무엇인가?
    디자이너의 역할 : UI, UX, GUI, VD, IXD의 차이 학습
    UX 디자인 프로세스 학습
    UX 리서치 & 필드 리서치
    데이터 모델링 & 서비스 기획 학습
    데이터 드리븐 UX 및 심리학 / 행동 경제학
    """
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
      $0.top.equalTo(titleBgView.snp.bottom).offset(margins)
      $0.leading.equalTo(titleBgView).offset(margins / 2)
      $0.trailing.equalTo(titleBgView).offset(-margins / 2)
      $0.bottom.equalTo(contentView).offset(-margins)
      $0.height.greaterThanOrEqualTo(100).priority(999)
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
