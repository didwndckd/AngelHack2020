//
//  SummaryCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {
  static let identifier = "SummaryCell"
  private let profileImageView = UIImageView()
  private let commentLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  private func attribute() {
    contentView.backgroundColor = #colorLiteral(red: 0.9452976584, green: 0.9455571771, blue: 0.9636406302, alpha: 1)
    profileImageView.backgroundColor = .lightGray
    profileImageView.layer.cornerRadius = 15
    profileImageView.clipsToBounds = true
    
    commentLabel.text = "큰 도움이 됐어요."
    commentLabel.textColor = .black
    commentLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    commentLabel.numberOfLines = 0
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [profileImageView, commentLabel]
      .forEach { contentView.addSubview($0) }
    
    profileImageView.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(contentView).offset(margins)
      $0.width.height.equalTo(30)
    }
    
    commentLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margins)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(margins)
      $0.trailing.equalTo(contentView).offset(-margins)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

protocol CommentInputCellDelegate: class {
  func addcomment(text: String)
}

class CommentInputCell: UITableViewCell {
  static let identifier = "RelayInputCell"
  weak var delegate: CommentInputCellDelegate?
  private let relayInputTextField = UITextField()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = #colorLiteral(red: 0.9452976584, green: 0.9455571771, blue: 0.9636406302, alpha: 1)
    relayInputTextField.borderStyle = .roundedRect
    relayInputTextField.returnKeyType = .done
    relayInputTextField.delegate = self
    
    contentView.addSubview(relayInputTextField)
    relayInputTextField.snp.makeConstraints {
      $0.top.leading.equalTo(contentView).offset(10)
      $0.trailing.bottom.equalTo(contentView).offset(-10)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CommentInputCell: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let text = textField.text {
      delegate?.addcomment(text: text)
    }
    return true
  }
}
