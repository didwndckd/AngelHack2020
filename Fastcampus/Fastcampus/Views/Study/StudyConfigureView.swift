//
//  StudyConfigureView.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol StudyConfigureViewDelegate: class {
  func cancelDidTap()
  func createDidTap()
}

class StudyConfigureView: View {
  
  weak var delegate: StudyConfigureViewDelegate?
  
  private var fixedCount = 0
  
  private let baseView = UIView()
  
  private let masterDisplayLabel = UILabel()
  private let masterBadgeLabel = BadgeLabel()
  private let masterNameLabel = UILabel()
  
  private let titleDisplayLabel = UILabel()
  private let titleTextField = UITextField()
  
  private let dateDisplayLabel = UILabel()
  private let dateStackView = UIStackView()
  private let mothButton = UIButton()
  private let dayButton = UIButton()
  private let hourButton = UIButton()
  private let minuteButton = UIButton()
  
  private let fixedDisplayLabel = UILabel()
  private let fixedButton = UIButton()
  
  private let ruleDisplayLabel = UILabel()
  private let ruleTextView = UITextView()
  
  private let cancelButton = UIButton()
  private let createButton = UIButton()
  
  
  private var baseViewCenterY: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    super.attribute()
    
    baseView.backgroundColor = .white
    baseView.layer.cornerRadius = 8
    baseView.layer.masksToBounds = true
    
    [masterDisplayLabel, titleDisplayLabel, dateDisplayLabel, fixedDisplayLabel, ruleDisplayLabel].forEach {
      $0.font = .boldSystemFont(ofSize: 16)
    }
    
    masterDisplayLabel.text = "방장"
    masterBadgeLabel.text = "Lv.9"
    masterBadgeLabel.font = .boldSystemFont(ofSize: 12)
    masterNameLabel.text = "업쓰"
    
    titleDisplayLabel.text = "스터디 제목"
    titleTextField.font = .boldSystemFont(ofSize: 20)
    titleTextField.layer.cornerRadius = 4
    titleTextField.backgroundColor = .gray
    
    dateDisplayLabel.text = "스터디 오픈시간"
    mothButton.setTitle("  월 ▾", for: .normal)
    dayButton.setTitle("  일 ▾", for: .normal)
    hourButton.setTitle("  시 ▾", for: .normal)
    minuteButton.setTitle("  분 ▾", for: .normal)
    [mothButton, dayButton, hourButton, minuteButton].forEach {
      $0.layer.cornerRadius = 4
      $0.backgroundColor = .gray
      dateStackView.addArrangedSubview($0)
    }
    dateStackView.axis = .horizontal
    dateStackView.distribution = .fillEqually
    dateStackView.spacing = 8
    dateStackView.alignment = .fill
    
    fixedDisplayLabel.text = "정원"
    fixedButton.setTitle("  명 ▾", for: .normal)
    fixedButton.layer.cornerRadius = 4
    fixedButton.backgroundColor = .gray
    
    ruleDisplayLabel.text = "규칙"
    
    ruleTextView.backgroundColor = .gray
    ruleTextView.layer.cornerRadius = 8
    ruleTextView.layer.masksToBounds = true
    
    cancelButton.setTitle("취소", for: .normal)
    cancelButton.setTitleColor(.white, for: .normal)
    cancelButton.backgroundColor = .gray
    cancelButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
    
    createButton.setTitle("스터디방 만들기", for: .normal)
    createButton.setTitleColor(.white, for: .normal)
    createButton.backgroundColor = .darkGray
    createButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
  }
  
  override func setupUI() {
    super.setupUI()
    
    self.addSubview(baseView)
    baseView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
    ])
    
    baseViewCenterY = baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    baseViewCenterY?.isActive = true
    
    [masterDisplayLabel, masterBadgeLabel, masterNameLabel,
     titleDisplayLabel, titleTextField,
     dateDisplayLabel, dateStackView,
     fixedDisplayLabel, fixedButton,
     ruleDisplayLabel, ruleTextView,
     cancelButton, createButton].forEach {
      baseView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let xSpace: CGFloat = 24
    let ySpace: CGFloat = 16
    let toSpace: CGFloat = 4
    let buttonHeight: CGFloat = 32
    
    [cancelButton, createButton].forEach {
      $0.topAnchor.constraint(equalTo: ruleTextView.bottomAnchor, constant: ySpace).isActive = true
      $0.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
      $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    NSLayoutConstraint.activate([
      masterDisplayLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: ySpace),
      masterDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      masterBadgeLabel.centerYAnchor.constraint(equalTo: masterDisplayLabel.centerYAnchor),
      masterBadgeLabel.leadingAnchor.constraint(equalTo: masterDisplayLabel.trailingAnchor, constant: toSpace),
      
      masterNameLabel.centerYAnchor.constraint(equalTo: masterDisplayLabel.centerYAnchor),
      masterNameLabel.leadingAnchor.constraint(equalTo: masterBadgeLabel.trailingAnchor, constant: toSpace),
      
      
      
      titleDisplayLabel.topAnchor.constraint(equalTo: masterDisplayLabel.bottomAnchor, constant: ySpace),
      titleDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      titleTextField.topAnchor.constraint(equalTo: titleDisplayLabel.bottomAnchor, constant: toSpace),
      titleTextField.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      titleTextField.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xSpace),
      
      
      
      dateDisplayLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: ySpace),
      dateDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      dateStackView.topAnchor.constraint(equalTo: dateDisplayLabel.bottomAnchor, constant: toSpace),
      dateStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      dateStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xSpace),
      dateStackView.heightAnchor.constraint(equalToConstant: buttonHeight),
      
      
      
      fixedDisplayLabel.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: ySpace),
      fixedDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      fixedButton.topAnchor.constraint(equalTo: fixedDisplayLabel.bottomAnchor, constant: toSpace),
      fixedButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      fixedButton.widthAnchor.constraint(equalTo: mothButton.widthAnchor),
      fixedButton.heightAnchor.constraint(equalToConstant: buttonHeight),
      
      
      
      ruleDisplayLabel.topAnchor.constraint(equalTo: fixedButton.bottomAnchor, constant: ySpace),
      ruleDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      ruleTextView.topAnchor.constraint(equalTo: ruleDisplayLabel.bottomAnchor, constant: toSpace),
      ruleTextView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      ruleTextView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xSpace),
      ruleTextView.heightAnchor.constraint(equalToConstant: 72),
      
      cancelButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
      
      createButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
      createButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
      createButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
    ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}



// MARK: - Action

extension StudyConfigureView {
  @objc private func stepperDidTap(_ sender: UIStepper) {
    fixedCount = Int(sender.value)
  }
  
  
  @objc private func buttonDidTap(_ sender: UIButton) {
    sender == cancelButton ? delegate?.cancelDidTap() : delegate?.createDidTap()
  }
}



// MARK: - Keyboard Notification

extension StudyConfigureView {
  func keyboardAction(_ notification: Notification) {
    guard
      let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
      let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
//      let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
      else { return }
    let height: CGFloat = 64
    
    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: UIView.AnimationOptions(rawValue: curve),
      animations: { [weak self] in
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
          self?.baseViewCenterY?.constant = -height
          
        case UIResponder.keyboardWillHideNotification:
          self?.baseViewCenterY?.constant = 0
          
        default:
          break
        }
        self?.layoutIfNeeded()
    })
  }
}
