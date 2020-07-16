//
//  SummaryHeaderView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryHeaderView: View {
  private let titleLabel = UILabel()
  private let userNameLabel = UILabel()
  private let contentsLabel = UILabel()
  private let replyCountLabel = UILabel()
  private let favoriteCountLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    super.attribute()
    titleLabel.text = "2회차 요약본(UX위주)"
    titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    
    userNameLabel.text = "조현철"
    userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    userNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    
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
    
    [titleLabel, userNameLabel, contentsLabel, replyCountLabel, favoriteCountLabel]
      .forEach { self.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(self).offset(margins)
    }
    
    userNameLabel.snp.makeConstraints {
      $0.top.equalTo(self).offset(margins)
      $0.leading.equalTo(titleLabel.snp.trailing).offset(margins)
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
