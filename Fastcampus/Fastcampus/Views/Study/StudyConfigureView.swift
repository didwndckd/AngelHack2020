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
  
  private var fixedCount = 0 {
    didSet { fixedCountLabel.text = String(fixedCount) + " 명" }
  }
  
  
  private let baseView = UIView()
  
  private let titleLabel = UILabel()
  private let datePicker = UIDatePicker()
  
  private let fixedTitleLabel = UILabel()
  private let fixedCountLabel = UILabel()
  private let fixedStepper = UIStepper()
  
  private let ruleTitleLabel = UILabel()
  private let ruleTextView = UITextView()
  
  private let masterTitleLabel = UILabel()
  private let masterNameLabel = UILabel()
  private let masterBadgeImageView = UIImageView()
  
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
    
    [titleLabel, fixedTitleLabel, ruleTitleLabel, masterTitleLabel].forEach {
      $0.font = .boldSystemFont(ofSize: 16)
    }
    
    titleLabel.text = "스터디 오픈시간"
    
    datePicker.datePickerMode = .countDownTimer
    datePicker.locale = Locale(identifier: "ko_KR")
    datePicker.setDate(Date(), animated: true)
    
    fixedTitleLabel.text = "정원"
    
    fixedCountLabel.text = String(fixedCount) + " 명"
    
    fixedStepper.minimumValue = 0
    fixedStepper.maximumValue = 10
    fixedStepper.stepValue = 1
    fixedStepper.addTarget(self, action: #selector(stepperDidTap(_:)), for: .valueChanged)
    
    ruleTitleLabel.text = "규칙"
    
    ruleTextView.backgroundColor = .lightGray
    ruleTextView.layer.cornerRadius = 8
    ruleTextView.layer.masksToBounds = true
    
    masterTitleLabel.text = "방장"
    
    masterNameLabel.text = "업쓰"
    
    masterBadgeImageView.image = UIImage(systemName: "tortoise.fill")
    
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
    
    [titleLabel, datePicker,
     fixedTitleLabel, fixedCountLabel, fixedStepper,
     ruleTitleLabel, ruleTextView,
     masterTitleLabel, masterNameLabel, masterBadgeImageView,
     cancelButton, createButton].forEach {
      baseView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let xSpace: CGFloat = 24
    let ySpace: CGFloat = 16
    
    [ruleTitleLabel, ruleTextView].forEach {
      $0.topAnchor.constraint(equalTo: fixedStepper.bottomAnchor, constant: ySpace).isActive = true
    }
    
    [masterTitleLabel, masterNameLabel, masterBadgeImageView].forEach {
      $0.topAnchor.constraint(equalTo: ruleTextView.bottomAnchor, constant: ySpace).isActive = true
    }
    
    [cancelButton, createButton].forEach {
      $0.topAnchor.constraint(equalTo: masterTitleLabel.bottomAnchor, constant: ySpace).isActive = true
      $0.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
      $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: ySpace),
      titleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      datePicker.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      datePicker.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xSpace),
      datePicker.heightAnchor.constraint(equalToConstant: 144),
      
      fixedTitleLabel.centerYAnchor.constraint(equalTo: fixedStepper.centerYAnchor),
      fixedTitleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      fixedCountLabel.centerYAnchor.constraint(equalTo: fixedStepper.centerYAnchor),
      fixedCountLabel.leadingAnchor.constraint(equalTo: fixedTitleLabel.trailingAnchor, constant: xSpace),
      
      fixedStepper.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xSpace),
      fixedStepper.topAnchor.constraint(equalTo: datePicker.bottomAnchor),
      
      ruleTitleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      ruleTextView.leadingAnchor.constraint(equalTo: ruleTitleLabel.trailingAnchor, constant: xSpace),
      ruleTextView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 0.6),
      ruleTextView.heightAnchor.constraint(equalToConstant: 160),
      
      masterTitleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      masterNameLabel.leadingAnchor.constraint(equalTo: masterTitleLabel.trailingAnchor, constant: xSpace),
      
      masterBadgeImageView.leadingAnchor.constraint(equalTo: masterNameLabel.trailingAnchor, constant: xSpace),
      
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
