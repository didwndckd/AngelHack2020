//
//  QuestionCell.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit



class QuestionCell: UITableViewCell {

  static let identifier = "QuestionCell"
  
  private let userNameLabel = UILabel()
  private let questionTimeLabel = UILabel()
  private let questionDescriptionLabel = UILabel()
  private let deleteButton = UIButton()
  private let cardView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    
    backgroundColor = .clear
    
    cardView.backgroundColor = .white
    cardView.shadow()
    cardView.layer.cornerRadius = 8
    
    userNameLabel.font = .systemFont(ofSize: 14, weight: .regular)
    userNameLabel.textColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    
    questionTimeLabel.font = .systemFont(ofSize: 14, weight: .light)
    questionTimeLabel.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
    
    questionDescriptionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    questionDescriptionLabel.textColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    
    deleteButton.setTitle("X", for: .normal)
    deleteButton.setTitleColor(.black, for: .normal)
    deleteButton.isHidden = true
    
  }
  
  private func setupUI() {
    
    let inset: CGFloat = 8
    let margin: CGFloat = 24
    let padding: CGFloat = 8
    
    contentView.addSubview(cardView)
    
    [deleteButton, userNameLabel, questionTimeLabel, questionDescriptionLabel].forEach({
      cardView.addSubview($0)
    })
    
    cardView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview().inset(inset)
    })
    
    deleteButton.snp.makeConstraints({
      $0.top.trailing.equalToSuperview()
    })
    
    userNameLabel.snp.makeConstraints({
      $0.top.leading.equalToSuperview().offset(margin)
    })
    
    questionTimeLabel.snp.makeConstraints({
      $0.centerY.equalTo(userNameLabel.snp.centerY)
      $0.leading.equalTo(userNameLabel.snp.trailing).offset(padding)
    })
    
    questionDescriptionLabel.snp.makeConstraints({
      $0.leading.trailing.bottom.equalToSuperview().inset(margin)
      $0.top.equalTo(userNameLabel.snp.bottom).offset(padding)
    })
    
  }
  
  func configure(qna: QnAModel) {
    userNameLabel.text = qna.userID
    questionTimeLabel.text = Double(qna.playTime).toTimeString
    questionDescriptionLabel.text = qna.title
  }
}
