//
//  SummaryHeaderView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol SummaryHeaderViewDelegate: class {
  func isFavorite(sender: UIButton)
}

class SummaryHeaderView: View {
  weak var delegate: SummaryHeaderViewDelegate?
  private let titleBgView = UIView()
  private let titleLabel = UILabel()
  private let favoriteButton = UIButton()
  private let levelLabel = UIButton()
  private let userNameLabel = UILabel()
  private let contentsLabel = UILabel()
  private let replyCountLabel = UILabel()
  private let favoriteCountLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func setProperties(summary: Summary, user: UserModel) {
    titleLabel.text = summary.title
    contentsLabel.text = summary.contents
    userNameLabel.text = user.nickName
    levelLabel.setTitle("Lv.\(user.level)", for: .normal)
  }
  
  override func attribute() {
    super.attribute()
    titleBgView.backgroundColor = #colorLiteral(red: 1, green: 0.9529311061, blue: 0.9375221133, alpha: 1)
    
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.numberOfLines = 0
    titleLabel.sizeToFit()
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.lineBreakMode = .byCharWrapping
    
    favoriteButton.setImage(#imageLiteral(resourceName: "icon_favorite_deselected"), for: .normal)
    favoriteButton.addTarget(self, action: #selector(touchUpFavoriteButton(_:)), for: .touchUpInside)
    
    levelLabel.setTitleColor(.red, for: .normal)
    levelLabel.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    levelLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 3)
    levelLabel.layer.borderColor = UIColor.red.cgColor
    levelLabel.layer.borderWidth = 1
    levelLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    
    userNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    contentsLabel.numberOfLines = 0
    contentsLabel.lineBreakMode = .byCharWrapping
    contentsLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    replyCountLabel.textColor = .lightGray
    replyCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    favoriteCountLabel.textColor = .lightGray
    favoriteCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
  }
  
  override func setupUI() {
    super.setupUI()
    let margins: CGFloat = 15
    
    [titleBgView, titleLabel, favoriteButton, levelLabel, userNameLabel, contentsLabel, replyCountLabel, favoriteCountLabel]
      .forEach { self.addSubview($0) }
    
    titleBgView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.height.equalTo(52)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(titleBgView)
      $0.leading.equalTo(self).offset(margins)
      $0.width.lessThanOrEqualTo(UIScreen.main.bounds.width / 1.4)
    }
    
    favoriteButton.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.leading.equalTo(titleLabel.snp.trailing).offset(margins / 3)
      $0.width.height.equalTo(44)
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

private extension SummaryHeaderView {
  @objc private func touchUpFavoriteButton(_ sender: UIButton) {
    delegate?.isFavorite(sender: sender)
  }
}
