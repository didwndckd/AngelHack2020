//
//  StudyReViewVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyReviewVC: ViewController<StudyReviewView>, KeyboardObserving, StudyReviewViewDelegate {
  
  private var model: [Qna]
  private var chat: [Message] = [] {
    didSet {
      
    }
  }
  
  init(qnas: [Qna]) {
    var qnas: [Qna] = []
    for i in 0...10 {
      let qna = Qna(documentID: "asfasfa", data: QnAModel(playTime: Int64(i), title: "title\(i)", userID: "userid\(i)", isDone: false, messages: []))
      qnas.append(qna)
    }
    self.model = qnas
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    registerForKeyboardEvents()
    
    
  }
  
  deinit {
    unregisterFromKeyboardEvents()
  }
  
  private func setupNavigation() {
    title = "질문 채팅"
    setBackButton(selector: #selector(popRootViewController(_:)))
  }
  
  
  // MARK: Observer
  
  func keyboardWillShow(_ notification: Notification) {
    guard
      let height = notification.keyboardSize?.height,
      let duration = notification.keyboardAnimationDuration
      else { return }
    print("duration", duration)
    UIView.animate(withDuration: duration, animations: {
      [weak self] in
      self?.customView.switchEditingMode(isEditing: true, height: height)
    })
    
  }
  
  func keyboardWillHide(_ notification: Notification) {
    guard
    let height = notification.keyboardSize?.height,
    let duration = notification.keyboardAnimationDuration
    else { return }
    print("duration", duration)
    UIView.animate(withDuration: duration, animations: {
      [weak self] in
      self?.customView.switchEditingMode(isEditing: false, height: height)
    })
    
  }
  
  // MARK: Action
  
  @objc private func popRootViewController(_ sender: UIBarButtonItem) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  
  
  
}


// MARK: UITableViewdataSource

extension StudyReviewVC {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    chat.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
}

// MARK: UITableviewDelegate
extension StudyReviewVC {
  
}


// MARK: UICollectionViewDataSource

extension StudyReviewVC {
  
}

// MARK: UICollectionViewDelegate

extension StudyReviewVC {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    model.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension StudyReviewVC: UICollectionViewDelegateFlowLayout {
  
}
