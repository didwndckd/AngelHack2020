//
//  ChattingCell.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ChattingCell: UITableViewCell {

  static let identifier = "ChattingCell"
  
  private let nameLabel = UILabel()
  private let profileView = CircleView()
  private let tempLabel = UILabel()
  private let messageLabel = InsetLabel(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    tempLabel.font = .systemFont(ofSize: 18, weight: .black)
    tempLabel.textColor = .gray
    tempLabel.textAlignment = .center
    
    
    nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
    nameLabel.textColor = .black
    nameLabel.textAlignment = .center
    
    messageLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    messageLabel.textColor = .black
    messageLabel.layer.cornerRadius = 8
    messageLabel.backgroundColor = .white
    messageLabel.clipsToBounds = true
    messageLabel.shadow()
    
    profileView.backgroundColor = .white
    profileView.shadow()
    profileView.clipsToBounds = true
    
  }
  
  private func setupUI() {
    
    [nameLabel, profileView, messageLabel].forEach({
      contentView.addSubview($0)
    })
    
    backgroundColor = .clear
    
    profileView.addSubview(tempLabel)
    
    tempLabel.snp.makeConstraints({
      $0.width.equalTo(tempLabel.snp.height)
      $0.leading.trailing.bottom.top.equalToSuperview().inset(8)
    })
    
    
  }
  
 
  
  func configure(message: MessageModel) {
    var nickName = "알수없음"
    if let nickNameIndex = UserService.allUser.firstIndex(where: {
      $0.uid == message.userID
    }) {
       nickName = UserService.allUser[nickNameIndex].nickName
    }
    
    
    
    let temp = nickName.isEmpty ? "": String(nickName.first!)
    tempLabel.text = temp
    nameLabel.text = nickName
    messageLabel.text = message.message.isEmpty ? " ": message.message
    let isMine = SignService.user.uid == message.userID
    remakeConstraint(isMine: isMine)
  }
  
  private func remakeConstraint(isMine: Bool) {
    let inset: CGFloat = 16
    let padding: CGFloat = 8
    
    if isMine {
      messageLabel.textAlignment = .right
      messageLabel.backgroundColor = #colorLiteral(red: 0.9920033813, green: 0.9459418654, blue: 0.9275759459, alpha: 1)
      profileView.snp.remakeConstraints({
        $0.top.trailing.equalToSuperview().inset(inset)
      })
      nameLabel.snp.remakeConstraints({
        $0.top.equalToSuperview().offset(inset)
        $0.trailing.equalTo(profileView.snp.leading).offset(-padding)
      })
      messageLabel.snp.remakeConstraints({
        $0.top.equalTo(nameLabel.snp.bottom).offset(padding)
        $0.trailing.equalTo(nameLabel)
//        $0.leading.equalToSuperview().offset(inset)
        $0.bottom.equalToSuperview().offset(-inset)
      })
    } else {
      messageLabel.textAlignment = .left
      messageLabel.backgroundColor = .white
      profileView.snp.remakeConstraints({
        $0.leading.top.equalToSuperview().inset(inset)
      })
      nameLabel.snp.remakeConstraints({
        $0.top.equalToSuperview().offset(inset)
        $0.leading.equalTo(profileView.snp.trailing).offset(padding)
      })
      messageLabel.snp.remakeConstraints({
        $0.top.equalTo(nameLabel.snp.bottom).offset(padding)
        $0.leading.equalTo(nameLabel)
//        $0.trailing.equalToSuperview().offset(-inset)
        $0.bottom.equalToSuperview().offset(-inset)
      })
      
    }
  }
  
}
