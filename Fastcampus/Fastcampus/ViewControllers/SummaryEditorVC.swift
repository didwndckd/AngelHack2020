//
//  SummaryEditorVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryEditorVC: ViewController<SummaryEditorView>, KeyboardObserving {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerForKeyboardEvents()
    attribute()
  }
  
  deinit {
    unregisterFromKeyboardEvents()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  func keyboardWillShow(_ notification: Notification) {
    customView.handleKeyboardWillShow(notification)
  }
  
  func keyboardWillHide(_ notification: Notification) {
    customView.handleKeyboardWillHide(notification)
  }
  
  private func attribute() {
    let photoButton = UIButton(type: .custom)
    photoButton.setImage(#imageLiteral(resourceName: "icon_photo_black"), for: .normal)
    photoButton.addTarget(self, action: #selector(touchUpPhotoButton), for: .touchUpInside)
    photoButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    let photoBarButton = UIBarButtonItem(customView: photoButton)
    
    let libraryButton = UIButton(type: .custom)
    libraryButton.setImage(#imageLiteral(resourceName: "icon_library_black"), for: .normal)
    libraryButton.addTarget(self, action: #selector(touchUpLibraryButton), for: .touchUpInside)
    libraryButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    let librayBarButton = UIBarButtonItem(customView: libraryButton)

    self.navigationItem.rightBarButtonItems = [photoBarButton, librayBarButton]
  }
}

private extension SummaryEditorVC {
  @objc private func touchUpLibraryButton() {
    print("[Log] : touchUpLibraryButton")
  }
  
  @objc private func touchUpPhotoButton() {
    print("[Log] : touchUpPhotoButton")
  }
}
