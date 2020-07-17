//
//  KeyboardControllable.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol KeyboardObserving: class {
  func keyboardWillShow(_ notification: Notification)
  func keyboardWillHide(_ notification: Notification)
}

extension KeyboardObserving where Self: UIViewController {
  func keyboardWillShow(_ notification: Notification) {}
  func keyboardWillHide(_ notification: Notification) {}
  func registerForKeyboardEvents() {
      _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
          self?.keyboardWillShow(notification)
      }
      
      _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
          self?.keyboardWillHide(notification)
      }
  }
  
  /// Unregister from UIKeyboard notifications.
  func unregisterFromKeyboardEvents() {
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}

protocol KeyboardControllable: class {
  func handleKeyboardWillShow(_ notification: Notification)
  func handleKeyboardWillHide(_ notification: Notification)
}

extension Notification {
    var keyboardSize: CGSize? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
    }
    var keyboardAnimationDuration: Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }
}
