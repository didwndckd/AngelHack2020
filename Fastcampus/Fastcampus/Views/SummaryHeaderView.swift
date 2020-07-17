//
//  SummaryHeaderView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryHeaderView: View {
  private let titleBgView = UIView()
  private let titleLabel = UILabel()
  private let levelLabel = UIButton()
  private let userNameLabel = UILabel()
  private let contentsLabel = UILabel()
  private let replyCountLabel = UILabel()
  private let favoriteCountLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    super.attribute()
    titleBgView.backgroundColor = #colorLiteral(red: 0.9456093907, green: 0.9452782273, blue: 0.9634839892, alpha: 1)
    
    titleLabel.text = "2회차 요약본(UX위주)"
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.numberOfLines = 0
    titleLabel.sizeToFit()
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.lineBreakMode = .byCharWrapping
    titleLabel.setContentHuggingPriority(.init(rawValue: 100), for: .horizontal)
    titleLabel.setContentCompressionResistancePriority(.init(rawValue: 500), for: .horizontal)
    
    levelLabel.setTitle("Lv.9", for: .normal)
    levelLabel.setTitleColor(.red, for: .normal)
    levelLabel.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    levelLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 3)
    levelLabel.layer.borderColor = UIColor.red.cgColor
    levelLabel.layer.borderWidth = 1
    levelLabel.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
    levelLabel.setContentCompressionResistancePriority(.init(rawValue: 750), for: .horizontal)
    
    userNameLabel.text = "조현철"
    userNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    userNameLabel.setContentHuggingPriority(.init(rawValue: 300), for: .horizontal)
    userNameLabel.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .horizontal)
    
    contentsLabel.text = """
    Excepteur sint occaecat cupidatat non proident, sunt in culpa
    qui officia deserunt mollit anim. Excepteur sint occaecat
    cupidatat non proident, sunt in culpa qui officia deserunt
    mollit anim.

    Excepteur sint occaecat cupidatat non proident, sunt in culpa
    qui officia deserunt mollit anim.
    qui officia deserunt mollit anim. Excepteur sint occaecat
    cupidatat non proident, sunt in culpa qui officia deserunt
    mollit anim.
    """
    contentsLabel.numberOfLines = 0
    contentsLabel.lineBreakMode = .byCharWrapping
    contentsLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    replyCountLabel.text = "댓글 2개"
    replyCountLabel.textColor = .lightGray
    replyCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    favoriteCountLabel.text = "저장 9개"
    favoriteCountLabel.textColor = .lightGray
    favoriteCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
  }
  
  override func setupUI() {
    super.setupUI()
    let margins: CGFloat = 15
    
    [titleBgView, titleLabel, levelLabel, userNameLabel, contentsLabel, replyCountLabel, favoriteCountLabel]
      .forEach { self.addSubview($0) }
    
    titleBgView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.height.equalTo(52)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(titleBgView)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(levelLabel.snp.leading).offset(-margins)
    }
    
    levelLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalTo(userNameLabel.snp.leading).offset(-margins / 3)
    }
    
    userNameLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalTo(self).offset(-margins)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins * 2)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
      $0.bottom.equalTo(replyCountLabel.snp.top).offset(-margins * 3)
    }
    
    replyCountLabel.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margins)
      $0.bottom.equalTo(self).offset(-margins)
    }
    
    favoriteCountLabel.snp.makeConstraints {
      $0.leading.equalTo(replyCountLabel.snp.trailing).offset(margins)
      $0.bottom.equalTo(self).offset(-margins)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
