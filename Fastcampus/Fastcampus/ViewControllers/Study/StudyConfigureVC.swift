//
//  StudyConfigureVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

class StudyConfigureVC: ViewController<StudyConfigureView> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    addKeyboardNotification()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    view.endEditing(true)
  }
}



// MARK: - UI

extension StudyConfigureVC {
  private func setUI() {
    view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    customView.delegate = self
  }
  
  private func addKeyboardNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationAction(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationAction(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc private func keyboardNotificationAction(_ notification: Notification) {
    customView.keyboardAction(notification)
  }
}



// MARK: - StudyConfigureViewDelegate

extension StudyConfigureVC: StudyConfigureViewDelegate {
  func cancelDidTap() {
    self.dismiss(animated: true)
  }
  
  func createDidTap(title: String?, moth: Int?, day: Int?, hour: Int?, minute: Int?, fixed: Int?, rule: String?) {
    guard let title = title else {
      alertNormal(title: "스터디 제목을 입력해주세요")
      return
    }
    
    guard
      let moth = moth, let day = day, let hour = hour, let minute = minute,
      let date = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2020, month: moth, day: day, hour: hour, minute: minute).date
      else {
        alertNormal(title: "스터디 오픈 시간을 입력해주세요")
        return
    }
    
    guard let fixed = fixed else {
      alertNormal(title: "정원을 정해주세요")
      return
    }
    
    
    guard let rule = rule else {
      alertNormal(title: "규틱을 정해주세요")
      return
    }
    
    let mStudy = StudyModel(
      title: title,
      lectureTitle: "아직 연결안됌",
      unitTitle: "아직 연결안됌",
      unitDescription: "자료없음",
      date: Timestamp(date: date),
      fixed: fixed,
      rule: rule,
      userIDs: ["방장uid"],
      qnaIDs: [String](),
      inProcess: .wait
    )
    
    
//    (
//      documentID: "test",
//      title: title,
//      date: Timestamp(date: date),
//      fixed: fixed,
//      rule: rule,
//      userIDs: ["방장uuid"],
//      qnaIDs: [String](),
//      inProcess: .wait
//    )
    
    presentIndicatorViewController()
    StudyService.createStudy(studyModel: mStudy) {
      self.dismissIndicatorViewController()
      self.dismiss(animated: true)
    }
  }
}

