//
//  StudyConfigureVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

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
  
  func createDidTap() {
    StudyService.getStudy { }
  }
}

