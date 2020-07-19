//
//  SummaryEditorVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SummaryEditorVC: ViewController<SummaryEditorView>, KeyboardObserving {
  private let db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerForKeyboardEvents()
    attribute()
  }
  
  private let lecture: Lecture
  private let chapter: ChapterModel
  private let unit: UnitModel
  
  init(lecture: Lecture, chapter: ChapterModel, unit: UnitModel) {
    self.lecture = lecture
    self.chapter = chapter
    self.unit = unit
    super.init(nibName: nil, bundle: nil)
  }
  
  deinit {
    unregisterFromKeyboardEvents()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  private func getUserInfo() {
     UserService.getData(uid: SignService.uid) { [weak self] result in
      guard let self = self else { return }
       switch result {
         case .success(let user):
          self.customView.setProperties(user: user)
         case .failure(let err):
           fatalError(err.localizedDescription)
       }
     }
   }
  
  func keyboardWillShow(_ notification: Notification) {
    customView.handleKeyboardWillShow(notification)
  }
  
  func keyboardWillHide(_ notification: Notification) {
    customView.handleKeyboardWillHide(notification)
  }
  
  private func attribute() {
    self.tabBarController?.tabBar.isHidden = true
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    self.view.isUserInteractionEnabled = true
    
    customView.delegate = self
    
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
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SummaryEditorVC {
  @objc private func touchUpLibraryButton() {
    print("[Log] : touchUpLibraryButton")
  }
  
  @objc private func touchUpPhotoButton() {
    print("[Log] : touchUpPhotoButton")
  }
  
  @objc private func endEditing() {
    self.view.endEditing(true)
  }
}

extension SummaryEditorVC: SummaryEditorViewDelegate {
  func uploadSummary(title: String, contents: String) {
    if title == "" {
      alertNormal(title: "제목 부족", message: "제목을 작성해 주세요.", handler: nil)
    } else if contents == "" {
      alertNormal(title: "내용 부족", message: "내용을 작성해 주세요.", handler: nil)
    } else {
      let appendData = Summary(
        userID: SignService.uid!,
        unitID: unit.index,
        title: title,
        contents: contents,
        isOpen: true,
        comments: [String]()
      )
      
      let data: [String: Any] = [
        "userID": SignService.uid!,
        "unitID": unit.index,
        "title": title,
        "contents": contents,
        "isOpen": true,
        "comments": [String]()
      ]
      db.collection("Summary")
        .document("\(lecture.id)")
        .collection("\(chapter.index)")
        .addDocument(data: data) { [weak self] error in
          guard let self = self else { return }
          if let _ = error {
            fatalError("Error Add Summary")
          } else {
            self.alertNormal(title: "등록 성공", message: "요약본을 등록하셨습니다.") { action in
              self.navigationController?.popViewController(animated: true)
              if let pvc = self.navigationController?.viewControllers.last as? LectureStartVC {
                pvc.summary.insert(appendData, at: 0)
              }
              
            }
          }
      }
    }
  }
}
