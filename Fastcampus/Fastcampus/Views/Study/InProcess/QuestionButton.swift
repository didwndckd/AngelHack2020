//
//  QuestionButton.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class QuestionButton: UIButton {
  
  private let textLabel = UILabel()
  private let plusImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setGradientBackground(colors: [.red, .orange])
  }
  
  private func attribute() {
    
    backgroundColor = .myRed
    
    textLabel.text = "질문 만들기"
    textLabel.textColor = .white
    textLabel.font = .systemFont(ofSize: 16, weight: .bold)
    
    plusImageView.tintColor = .white
    plusImageView.image = UIImage(systemName: "plus")
    plusImageView.contentMode = .scaleAspectFit
    
  }
  
  private func setupUI() {
    [textLabel, plusImageView].forEach({
      addSubview($0)
    })
    
    let xMargin: CGFloat = 24
    let yMargin: CGFloat = 12
    
    textLabel.snp.makeConstraints({
      $0.leading.equalToSuperview().offset(xMargin)
      $0.top.bottom.equalToSuperview().inset(yMargin)
    })
    
    plusImageView.snp.makeConstraints({
      $0.trailing.equalToSuperview().offset(-xMargin)
      $0.top.bottom.equalToSuperview().inset(yMargin)
    })
  }
}
