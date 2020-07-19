//
//  QuestionCollectionViewCell.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
  static let idenifier = "QuestionCollectionViewCell"
  private let qImageView = UIImageView(image: UIImage(named: "Q"))
  private let titleLabel = UILabel()
  private let indexLabel = UILabel()
  private let userIDLabel = UILabel()
  private let contentLabel = UILabel()
  private let scrollView = UIScrollView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    
    contentView.shadow()
    contentView.makeGradient()
    contentView.layer.cornerRadius = 8
    contentView.clipsToBounds = true
    
    titleLabel.textColor = .white
    titleLabel.font = .systemFont(ofSize: 24, weight: .black)
    titleLabel.text = " "
    
    indexLabel.textColor = .white
    indexLabel.font = .systemFont(ofSize: 16, weight: .thin)
    
    userIDLabel.textColor = .white
    userIDLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    
    contentLabel.textColor = .black
    contentLabel.font = .systemFont(ofSize: 16, weight: .medium)
    contentLabel.numberOfLines = 0
    
    scrollView.backgroundColor = .white
    scrollView.layer.cornerRadius = 8
    
  }
  
  private func setupUI() {
    
    [qImageView, titleLabel, indexLabel, userIDLabel, scrollView].forEach({
      contentView.addSubview($0)
    })
    scrollView.addSubview(contentLabel)
    
    let inset: CGFloat = 16
    let titleMargin: CGFloat = 16
    let padding: CGFloat = 8
    
    qImageView.snp.makeConstraints({
      $0.top.leading.equalToSuperview().offset(inset)
    })
    
    titleLabel.snp.makeConstraints({
      $0.centerY.equalTo(qImageView)
      $0.leading.equalTo(qImageView.snp.trailing).offset(titleMargin)
    })
    
    indexLabel.snp.makeConstraints({
      $0.trailing.equalToSuperview().offset(-inset)
      $0.centerY.equalTo(titleLabel)
    })
    
    userIDLabel.snp.makeConstraints({
      $0.leading.equalToSuperview().offset(inset)
      $0.top.equalTo(qImageView.snp.bottom).offset(padding)
    })
    
    scrollView.snp.makeConstraints({
      $0.top.equalTo(userIDLabel.snp.bottom).offset(padding)
      $0.leading.trailing.bottom.equalToSuperview().inset(inset)
    })
    
    contentLabel.snp.makeConstraints({
      $0.top.leading.trailing.bottom.equalToSuperview().inset(padding)
    })
    
  }
  
  func configure(qna: QnAModel, index: Int, count: Int) {
    indexLabel.text = "\(index + 1)/\(count)"
    userIDLabel.text = "\(qna.userID)님 질문"
    contentLabel.text = qna.title
    
  }
  
}
