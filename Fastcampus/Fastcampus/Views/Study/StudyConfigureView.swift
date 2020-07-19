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
  func createDidTap(title: String?, moth: Int?, day: Int?, hour: Int?, minute: Int?, fixed: Int?, rule: String?)
}

class StudyConfigureView: View {
  
  weak var delegate: StudyConfigureViewDelegate?
  
  var title: String?
  var moth: Int?
  var day: Int?
  var hour: Int?
  var minute: Int?
  var fixed: Int?
  var rule: String?
  
  private let baseView = UIView()
  
  private let masterDisplayLabel = UILabel()
  private let masterBadgeLabel = BadgeLabel()
  private let masterNameLabel = UILabel()
  
  private let titleDisplayLabel = UILabel()
  private let titleTextField = UITextField()
  
  private let dateDisplayLabel = UILabel()
  private let monthDropView = DropButtonView(amount: 12, title: "월 ▾")
  private let dayDropView = DropButtonView(amount: 31, title: "일 ▾")
  private let hourDropView = DropButtonView(amount: 24, title: "시 ▾")
  private let minuteDropView = DropButtonView(amount: 60, title: "분 ▾")
  
  private let fixedDisplayLabel = UILabel()
  private let fixedDropView = DropButtonView(amount: 10, title: "명 ▾")
  
  private let ruleDisplayLabel = UILabel()
  private let ruleTextView = UITextView()
  
  private let cancelButton = UIButton()
  private let createButton = UIButton()
  
  
  private var baseViewCenterY: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func setJoinStyle(study: StudyModel) {
    [titleTextField, monthDropView, dayDropView, hourDropView, minuteDropView, fixedDropView, ruleTextView].forEach {
      $0.isUserInteractionEnabled = false
    }
    
    titleTextField.text = study.title
    let formatter = DateFormatter()
    formatter.dateFormat = "M월 d일 H시 m분"
    let date = formatter.string(from: study.date.dateValue())
    let dateList = date.split(separator: " ")
    monthDropView.setTitle("\(dateList[0].dropLast())월 ▾")
    dayDropView.setTitle("\(dateList[1].dropLast())일 ▾")
    hourDropView.setTitle("\(dateList[2].dropLast())시 ▾")
    minuteDropView.setTitle("\(dateList[3].dropLast())분 ▾")
    fixedDropView.setTitle("\(study.fixed)명 ▾")
    ruleTextView.text = study.rule
    createButton.setTitle("스터디 참여하기", for: .normal)
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
    masterBadgeLabel.text = "Lv.\(SignService.user.level)"
    masterBadgeLabel.font = .boldSystemFont(ofSize: 12)
    masterNameLabel.text = SignService.user.nickName
    
    titleDisplayLabel.text = "스터디 제목"
    titleTextField.font = .boldSystemFont(ofSize: 17)
    titleTextField.layer.cornerRadius = 4
    titleTextField.backgroundColor = .myGray
    titleTextField.delegate = self
    
    dateDisplayLabel.text = "스터디 오픈"
    
    fixedDisplayLabel.text = "정원"
    fixedDropView.delegate = self
    
    ruleDisplayLabel.text = "규칙"
    
    ruleTextView.backgroundColor = .myGray
    ruleTextView.layer.cornerRadius = 8
    ruleTextView.layer.masksToBounds = true
    ruleTextView.delegate = self
    
    cancelButton.setTitle("취소", for: .normal)
    cancelButton.setTitleColor(.gray, for: .normal)
    cancelButton.backgroundColor = .myGray
    cancelButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
    
    createButton.setTitle("스터디방 만들기", for: .normal)
    createButton.setTitleColor(.white, for: .normal)
    createButton.backgroundColor = .myRed
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
     dateDisplayLabel, monthDropView, dayDropView, hourDropView, minuteDropView,
     fixedDisplayLabel, fixedDropView,
     ruleDisplayLabel, ruleTextView,
     cancelButton, createButton].forEach {
      baseView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let xSpace: CGFloat = 24
    let ySpace: CGFloat = 16
    let toSpace: CGFloat = 4
    let buttonHeight: CGFloat = 32
    let ySpace2: CGFloat = ySpace + toSpace + buttonHeight
    
    let dateDropViews = [monthDropView, dayDropView, hourDropView, minuteDropView]
      
    dateDropViews.enumerated().forEach {
      $1.delegate = self
      $1.topAnchor.constraint(equalTo: dateDisplayLabel.bottomAnchor, constant: toSpace).isActive = true
      
      switch $0 {
      case 0:
        $1.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace).isActive = true
        
      case 3:
        $1.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xSpace).isActive = true
        fallthrough
        
      default:
        $1.leadingAnchor.constraint(equalTo: dateDropViews[$0 - 1].trailingAnchor, constant: 12).isActive = true
        $1.widthAnchor.constraint(equalTo: dateDropViews[$0 - 1].widthAnchor).isActive = true
      }
    }
    
    
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
      titleTextField.heightAnchor.constraint(equalToConstant: buttonHeight),
      
      
      
      dateDisplayLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: ySpace),
      dateDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      
      
      fixedDisplayLabel.topAnchor.constraint(equalTo: dateDisplayLabel.bottomAnchor, constant: ySpace2),
      fixedDisplayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      fixedDropView.topAnchor.constraint(equalTo: fixedDisplayLabel.bottomAnchor, constant: toSpace),
      fixedDropView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      fixedDropView.widthAnchor.constraint(equalTo: monthDropView.widthAnchor),
      
      
      
      ruleDisplayLabel.topAnchor.constraint(equalTo: fixedDisplayLabel.bottomAnchor, constant: ySpace2),
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

private extension StudyConfigureView {
  @objc private func stepperDidTap(_ sender: UIStepper) {
    fixed = Int(sender.value)
  }
  
  
  @objc private func buttonDidTap(_ sender: UIButton) {
    sender == cancelButton ?
      delegate?.cancelDidTap() :
      delegate?.createDidTap(title: title, moth: moth, day: day, hour: hour, minute: minute, fixed: fixed, rule: rule)
  }
}



extension StudyConfigureView: UITextViewDelegate, UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    title = textField.text
  }
  
  func textViewDidChange(_ textView: UITextView) {
    rule = textView.text
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

extension StudyConfigureView: DropButtonViewDelegate {
  func selectedElement(_ view: UIView, _ element: Int) {
    switch view {
    case monthDropView:    moth = element
    case dayDropView:     day = element
    case hourDropView:    hour = element
    case minuteDropView:  minute = element
    case fixedDropView:   fixed = element
    default:              break
    }
  }
  
  func titlButtonDidTap(_ view: UIView) {
    let dropViews = [monthDropView, dayDropView, hourDropView, minuteDropView, fixedDropView]
    
    dropViews.forEach {
      guard $0 != view else { return }
      $0.isFold = true
    }
  }
}
