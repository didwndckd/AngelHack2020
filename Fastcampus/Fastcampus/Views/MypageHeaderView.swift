//
//  SideMenuHeaderView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MypageHeaderView: View {
  private let nameLabel = UILabel()
  private let levelLabel = UIButton()
  private let recommendLabel = UILabel()
  private let writingLabel = UILabel()
  private let enterImageView = UIImageView()
  private let bottomSeparatorView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    self.backgroundColor = #colorLiteral(red: 1, green: 0.9529311061, blue: 0.9375221133, alpha: 1)
    enterImageView.image = #imageLiteral(resourceName: "icon_enter_black")
    enterImageView.contentMode = .scaleAspectFit
    
    nameLabel.text = "김패캠 님"
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)
    let attributedStr = NSMutableAttributedString(string: nameLabel.text!)
    attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 27), range: (nameLabel.text! as NSString as NSString).range(of: "님"))
    nameLabel.attributedText = attributedStr
    
    
    levelLabel.setTitle("Lv.9", for: .normal)
    levelLabel.setTitleColor(.red, for: .normal)
    levelLabel.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
    levelLabel.layer.borderWidth = 1
    levelLabel.layer.borderColor = UIColor.red.cgColor
    levelLabel.contentEdgeInsets = UIEdgeInsets(top: 3, left: 7, bottom: 3, right: 7)
    
    recommendLabel.text = "받은 추천 수 : 299개"
    recommendLabel.textColor = .lightGray
    recommendLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    writingLabel.text = "작성한 요약본 : 32개"
    writingLabel.textColor = .lightGray
    writingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    bottomSeparatorView.backgroundColor = UIColor.myRed
  }
  
  override func setupUI() {
    let margins: CGFloat = 15
    [nameLabel, levelLabel, recommendLabel, writingLabel, enterImageView, bottomSeparatorView]
      .forEach { self.addSubview($0) }
    
    nameLabel.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margins * 2)
      $0.bottom.equalTo(self.snp.centerY)
    }
    
    levelLabel.snp.makeConstraints {
      $0.centerY.equalTo(nameLabel)
      $0.leading.equalTo(nameLabel.snp.trailing).offset(margins / 2)
    }
    
    enterImageView.snp.makeConstraints {
      $0.centerY.equalTo(self.snp.centerY)
      $0.trailing.equalTo(self).offset(-margins)
      $0.width.height.equalTo(44)
    }
    
    recommendLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(margins)
      $0.leading.equalTo(self).offset(margins * 2)
    }
    
    writingLabel.snp.makeConstraints {
      $0.top.equalTo(recommendLabel.snp.bottom)
      $0.leading.equalTo(self).offset(margins * 2)
    }
    
    bottomSeparatorView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalTo(self)
      $0.height.equalTo(3)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
