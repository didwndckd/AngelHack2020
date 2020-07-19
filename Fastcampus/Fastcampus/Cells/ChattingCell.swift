//
//  ChattingCell.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ChattingCell: UITableViewCell {

  private let identifier = "ChattingCell"
  
  private let nameLabel = UILabel()
  private let profileView = UIView()
  private let tempLabel = UILabel()
  private let messageLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    
  }
  
  private func setupUI() {
    
    [nameLabel, profileView, messageLabel].forEach({
      contentView.addSubview($0)
    })
    
    profileView.addSubview(tempLabel)
    
  }
  
  func configure(message: MessageModel) {
    let temp = message.userID.isEmpty ? "": String(message.userID.first!)
    tempLabel.text = temp
    nameLabel.text = message.userID
    messageLabel.text = message.message
//    let myID = SignService.user. == message.userID
  }
  
  private func remakeConstraint(isMine: Bool) {
    let inset: CGFloat = 16
    let padding: CGFloat = 8
    
    if isMine {
      profileView.snp.remakeConstraints({
        $0.top.trailing.equalToSuperview().inset(inset)
      })
      nameLabel.snp.remakeConstraints({
        $0.top.equalToSuperview().offset(inset)
        $0.trailing.equalTo(profileView.snp.leading).offset(-padding)
      })
      messageLabel.snp.remakeConstraints({
        $0.top.equalTo(nameLabel.snp.top).offset(padding)
        $0.trailing.equalTo(nameLabel)
        $0.leading.equalToSuperview().offset(inset)
      })
    } else {
      profileView.snp.remakeConstraints({
        $0.leading.top.equalToSuperview().inset(inset)
      })
      nameLabel.snp.remakeConstraints({
        $0.top.equalToSuperview().offset(inset)
        $0.leading.equalTo(profileView.snp.trailing).offset(padding)
      })
      messageLabel.snp.remakeConstraints({
        $0.top.equalTo(nameLabel.snp.top).offset(-padding)
        $0.leading.equalTo(nameLabel)
        $0.trailing.equalToSuperview().offset(-inset)
      })
      
    }
  }
  
}
