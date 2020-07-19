//
//  SummaryEditorView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol SummaryEditorViewDelegate: class {
  func uploadSummary(title: String, contents: String)
}

class SummaryEditorView: View, KeyboardControllable {
  weak var delegate: SummaryEditorViewDelegate?
  private let summaryScrollView = UIScrollView()
  private let titleBgView = UIView()
  private let titleTextField = UITextField()
  private let levelLabel = UIButton()
  private let userNameLabel = UILabel()
  private let contextTextView = UITextView()
  
  private let cancelButton = UIButton()
  private let registButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func setProperties(user: UserModel) {
    levelLabel.setTitle("Lv.\(user.level)", for: .normal)
    userNameLabel.text = user.nickName
  }
  
  func handleKeyboardWillShow(_ notification: Notification) {
    let keyboardHeight = notification.keyboardSize?.height ?? 250
    cancelButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-keyboardHeight)
    }
    
    registButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-keyboardHeight)
    }
    
    layoutIfNeeded()
  }
  
  func handleKeyboardWillHide(_ notification: Notification) {
    cancelButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
    }
    
    registButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
    }
    
    layoutIfNeeded()
  }
  
  override func attribute() {
    super.attribute()
    titleBgView.backgroundColor = #colorLiteral(red: 1, green: 0.9529311061, blue: 0.9375221133, alpha: 1)

    titleTextField.placeholder = "제목을 입력해 주세요."
    titleTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleTextField.setContentHuggingPriority(.init(rawValue: 100), for: .horizontal)
    titleTextField.setContentCompressionResistancePriority(.init(rawValue: 500), for: .horizontal)
    titleTextField.backgroundColor = .clear
    
    levelLabel.setTitle("Lv.9", for: .normal)
    levelLabel.setTitleColor(.red, for: .normal)
    levelLabel.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    levelLabel.contentEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 3)
    levelLabel.layer.borderColor = UIColor.red.cgColor
    levelLabel.layer.borderWidth = 1
    levelLabel.setContentHuggingPriority(.init(rawValue: 200), for: .horizontal)
    levelLabel.setContentCompressionResistancePriority(.init(rawValue: 750), for: .horizontal)
    
    userNameLabel.text = "조현철"
    userNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    userNameLabel.setContentHuggingPriority(.init(rawValue: 300), for: .horizontal)
    userNameLabel.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .horizontal)
    
    contextTextView.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    cancelButton.setTitle("취소", for: .normal)
    cancelButton.setTitleColor(.gray, for: .normal)
    cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    cancelButton.backgroundColor = #colorLiteral(red: 0.9112721086, green: 0.9109323621, blue: 0.9292862415, alpha: 1)
    
    registButton.setTitle("요약본 올리기", for: .normal)
    registButton.setTitleColor(.white, for: .normal)
    registButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    registButton.addTarget(self, action: #selector(touchUpRegistButton), for: .touchUpInside)
    registButton.makeGradient()
  }
  
  override func setupUI() {
    super.setupUI()
    let guide = self.safeAreaLayoutGuide
    let margins: CGFloat = 15
    
    [titleBgView, titleTextField, levelLabel, userNameLabel, contextTextView, cancelButton, registButton]
      .forEach { self.addSubview($0) }
    
    titleBgView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top)
      $0.leading.trailing.equalTo(self)
      $0.height.equalTo(52)
    }
    
    titleTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(titleBgView)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(levelLabel.snp.leading).offset(-margins)
    }
    
    levelLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleTextField)
      $0.trailing.equalTo(userNameLabel.snp.leading).offset(-margins / 3)
    }
    
    userNameLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleTextField)
      $0.trailing.equalTo(self).offset(-margins)
    }
    
    contextTextView.snp.makeConstraints {
      $0.top.equalTo(titleBgView.snp.bottom).offset(margins * 2)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
      $0.bottom.equalTo(cancelButton.snp.top).offset(-margins * 3)
    }
    
    cancelButton.snp.makeConstraints {
      $0.leading.equalTo(self)
      $0.bottom.equalTo(guide.snp.bottom)
      $0.height.equalTo(56)
    }
    
    registButton.snp.makeConstraints {
      $0.leading.equalTo(cancelButton.snp.trailing)
      $0.trailing.equalTo(self)
      $0.bottom.equalTo(guide.snp.bottom)
      $0.height.equalTo(56)
      $0.width.equalTo(cancelButton)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    registButton.makeGradient()
  }
}

private extension SummaryEditorView {
  @objc private func touchUpRegistButton() {
    delegate?.uploadSummary(
      title: titleTextField.text ?? "",
      contents: contextTextView.text
    )  
  }
}
