//
//  QuestionCell.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewHeaderFooterView {

  static let identifier = "QuestionCell"
  
  private let userIDLabel = UILabel()
  private let titleLabel = UILabel()
  
  private let topView = UIView()
  private let bottomButton = UIButton()
  private let bodyView = UIView()
  
  private let closeButton = UIButton()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
//    backgroundColor = .clear
    [bodyView, closeButton].forEach({
      contentView.addSubview($0)
    })
    [topView, bottomButton].forEach({
      bodyView.addSubview($0)
    })
    [userIDLabel, titleLabel].forEach({
      topView.addSubview($0)
    })
    
    let backgroundView = UIView()
    backgroundView.backgroundColor = .clear
    
    self.backgroundView = backgroundView
    
    bodyView.layer.cornerRadius = 8
    bodyView.shadow()
    bodyView.clipsToBounds = true
    
    topView.backgroundColor = .white
    
    let inset: CGFloat = 16
    bottomButton.backgroundColor = #colorLiteral(red: 0.9455112815, green: 0.9456472993, blue: 0.9625509381, alpha: 1)
    bottomButton.setTitle("aa", for: .normal)
//    bottomButton.tintColor = .black
    bottomButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
    bottomButton.titleLabel?.textColor = .black
    bottomButton.titleLabel?.textAlignment = .natural
    bottomButton.contentHorizontalAlignment = .leading
    bottomButton.contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    
    userIDLabel.font = .systemFont(ofSize: 16, weight: .light)
    userIDLabel.textColor = .gray
    
    closeButton.setTitle("X", for: .normal)
    closeButton.titleLabel?.font = .systemFont(ofSize: 24)
    closeButton.setTitleColor(.black, for: .normal)
    closeButton.tintColor = .black
    
    titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
  }
  
  private func setupUI() {
    let margin: CGFloat = 8
    
    closeButton.snp.makeConstraints({
      $0.top.trailing.equalToSuperview().inset(margin)
    })
    
    bodyView.snp.makeConstraints({
      $0.top.equalTo(closeButton.snp.bottom).offset(margin)
      $0.leading.trailing.bottom.equalToSuperview().inset(margin)
    })
    bodyView.backgroundColor = .red
    
    topView.snp.makeConstraints({
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.7)
    })

    bottomButton.snp.makeConstraints({
      $0.bottom.leading.trailing.equalToSuperview()
      $0.top.equalTo(topView.snp.bottom)
    })

    userIDLabel.snp.makeConstraints({
      $0.top.leading.equalToSuperview().offset(margin)
    })

    titleLabel.snp.makeConstraints({
      $0.leading.trailing.equalToSuperview().inset(margin)
      $0.centerY.equalToSuperview()
    })
  }
  
  func configure(qna: QnAModel) {
    titleLabel.text = qna.title
    userIDLabel.text = qna.userID
    bottomButton.titleLabel?.text = "등록된 답변 \(3)개  좋아요 \(25)개"
  }
}
