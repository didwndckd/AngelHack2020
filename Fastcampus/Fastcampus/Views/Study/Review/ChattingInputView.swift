//
//  ChattinInputView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit


class ChattingInpuView: View {
  
  private let backgroundView = UIView()
  private let inputTextField = UITextField()
  private let sendButton = UIButton()
  
  override func attribute() {
    super.attribute()
    
    backgroundView.backgroundColor = .white
    backgroundView.shadow()
    
    sendButton.setImage(UIImage(named: "Send"), for: .normal)
    sendButton.backgroundColor = .myRed
  }
  
  override func setupUI() {
    super.setupUI()
    
    addSubview(backgroundView)
    [inputTextField, sendButton].forEach({
      backgroundView.addSubview($0)
    })
    
    let leftMargin: CGFloat = 16
    let inset: CGFloat = 8
    
    backgroundView.snp.makeConstraints({
      $0.top.leading.trailing.bottom.equalToSuperview()
    })
    
    inputTextField.snp.makeConstraints({
      $0.leading.equalToSuperview().offset(leftMargin)
      $0.top.bottom.equalToSuperview()
    })
    inputTextField.backgroundColor = .green
    sendButton.snp.makeConstraints({
      $0.trailing.top.bottom.equalToSuperview().inset(inset)
      $0.leading.equalTo(inputTextField.snp.trailing).offset(inset)
      $0.width.equalTo(sendButton.snp.height)
    })
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundView.layer.cornerRadius = backgroundView.bounds.height / 2
    sendButton.layer.cornerRadius = sendButton.bounds.width / 2
  }
  
  
}
