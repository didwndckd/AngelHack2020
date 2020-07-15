//
//  SideMenuHeaderView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SideMenuHeaderView: View {
  private let nameLabel = UILabel()
  private let levelLabel = UIButton()
  private let recommendLabel = UILabel()
  private let writingLabel = UILabel()
  private let enterImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    enterImageView.image = #imageLiteral(resourceName: "icon_enter_black")
    enterImageView.contentMode = .scaleAspectFit
    
    nameLabel.text = "김패캠 님"
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 27, weight: .black)
    let attributedStr = NSMutableAttributedString(string: nameLabel.text!)
    attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 27), range: (nameLabel.text! as NSString as NSString).range(of: "님"))
    nameLabel.attributedText = attributedStr
    
    
    levelLabel.setTitle("Lv.9", for: .normal)
    levelLabel.setTitleColor(.black, for: .normal)
    levelLabel.titleLabel?.font = UIFont.systemFont(ofSize: 9, weight: .regular)
    levelLabel.layer.borderWidth = 1
    levelLabel.layer.borderColor = UIColor.black.cgColor
    levelLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 3)
    
    recommendLabel.text = "받은 추천 수 : 299개"
    recommendLabel.textColor = .lightGray
    recommendLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    writingLabel.text = "작성한 요약본 : 32개"
    writingLabel.textColor = .lightGray
    writingLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
  }
  
  override func setupUI() {
    let margins: CGFloat = 15
    [nameLabel, levelLabel, recommendLabel, writingLabel, enterImageView]
      .forEach { self.addSubview($0) }
    
    nameLabel.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(self).offset(margins)
    }
    
    levelLabel.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(nameLabel.snp.trailing).offset(margins / 2)
    }
    
    enterImageView.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.trailing.equalTo(self).offset(-margins)
    }
    
    recommendLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(margins)
      $0.leading.equalTo(self).offset(margins)
    }
    
    writingLabel.snp.makeConstraints {
      $0.top.equalTo(recommendLabel.snp.bottom)
      $0.leading.equalTo(self).offset(margins)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
