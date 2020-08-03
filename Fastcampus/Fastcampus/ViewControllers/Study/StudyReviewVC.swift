//
//  StudyReViewVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

class StudyReviewVC: ViewController<StudyReviewView>, KeyboardObserving, StudyReviewViewDelegate {
  
  private var study: Study
  private var model: [QnA]
  private var messages: [MessageModel] = [] {
    didSet {
      customView.reLoadTableView(index: messages.count)
    }
  }
  private var index = 0
  
  private let questionItemMargin: CGFloat = 8
  private let questionItemSpacing: CGFloat = 8
  
  init(study: Study, qnas: [QnA]) {
    self.model = qnas
    self.study = study
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    registerForKeyboardEvents()
    customView.setDelegate(delegate: self)
    updateMessages(0)
    setNavigation()
//    questCollectionUserInteraction() // 방장만 질문 스크롤 가능하게 함
  }
  
  
  private func setNavigation() {
    let completeButton = UIBarButtonItem(title: "스터디 종료", style: .done, target: self, action: #selector(didTapCompleteButton(_:)))
    completeButton.tintColor = .black
    navigationItem.rightBarButtonItem = completeButton
  }
  
  private func questCollectionUserInteraction() {
    guard SignService.uid != study.data.userIDs[0] else { return }
    customView.questionInteractionEnabled()
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
      guard let self = self else { return }
      self.customView.switchEditingMode(isEditing: true, height: height)
      guard !self.messages.isEmpty else { return }
      self.customView.reLoadTableView(index: self.messages.count)
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
      guard let self = self else { return }
      self.customView.switchEditingMode(isEditing: false, height: height)
      guard !self.messages.isEmpty else { return }
      self.customView.reLoadTableView(index: self.messages.count)
    })
    
  }
  
  // MARK: Action
  
  @objc private func popRootViewController(_ sender: UIBarButtonItem) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  func updateMessages(_ index: Int) {
    guard index >= 0 && index < model.count else { return }
    let documentID = model[index].documentID
    StudyService.messageAddListener(qnaDocumentID: documentID, completion: {
      result in
      switch result {
      case .failure(let e):
        print(e.localizedDescription)
      case .success(let messages):
//        print(messages)
        self.messages = messages.sorted(by: {  $0.dateValue < $1.dateValue })
      }
    })
  }
  
  @objc private func didTapCompleteButton(_ sender: UIBarButtonItem) {
    guard study.data.userIDs[0] == SignService.uid else { return }
    var study = self.study.data
    study.inProcess = .finished
    navigationController?.popToRootViewController(animated: true)
  }
  
  private func questionItemWidth(scrollView: UIScrollView) -> CGFloat {
    let margin = questionItemMargin * 2
    let spacing = questionItemSpacing * 2
    return scrollView.bounds.width - margin - spacing
  }
  
}


// MARK: UITableViewdataSource

extension StudyReviewVC {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ChattingCell.identifier, for: indexPath) as! ChattingCell
    cell.configure(message: messages[indexPath.row])
    
    return cell
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.idenifier, for: indexPath) as! QuestionCollectionViewCell
    cell.configure(qna: model[indexPath.row].data, index: indexPath.row, count: model.count)
    return cell
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    guard let _ = scrollView as? UICollectionView else { return }
    let offsetX = scrollView.contentOffset.x
    
    let pageWidth = questionItemWidth(scrollView: scrollView) + questionItemSpacing
    
    let index = Int(((offsetX + questionItemMargin) / pageWidth))
    self.index = index
    updateMessages(index)
//    print(scrollView.contentOffset.x)
  }
  
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
    guard let _ = scrollView as? UICollectionView else { return }
    
    let offsetX = scrollView.contentOffset.x
    
    let pageWidth = questionItemWidth(scrollView: scrollView) + questionItemSpacing
    
    let index = ((offsetX + questionItemMargin) / pageWidth)
    var multiplier = round(index)
    
    print("=====================================================================")
    print("contentOffset:", scrollView.contentOffset.x)
    print("pointeeOffset:", targetContentOffset.pointee.x)
    print("index", index)
    print("ceil", ceil(index), "floor", floor(index), "multiplier", multiplier)
    print("velocity", velocity)
    
    if velocity.x > 0 {
      multiplier = ceil(index)
    } else if velocity.x < 0 {
      multiplier = floor(index)
    } 
    
    let updateOffsetX = (pageWidth * multiplier) - questionItemMargin
    
    targetContentOffset.pointee = CGPoint(x: updateOffsetX, y: 0)
  }
  
}

// MARK: UICollectionViewDelegateFlowLayout

extension StudyReviewVC: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let inset: CGFloat = 8
    return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let inset: CGFloat = 8
    let height = collectionView.bounds.height - (inset * 2)
    let width = questionItemWidth(scrollView: collectionView)
    return CGSize(width: width, height: height)
  }
}

// MARK: ChattingInputViewDelegate
extension StudyReviewVC {
  func sendMessage(_ message: String) {
    let messageModel = MessageModel(date: Timestamp(date: Date()), userID: SignService.user.uid, message: message)
    let qnaDocumentID = model[index].documentID
    StudyService.updateMessage(qnaDocumentID: qnaDocumentID, message: messageModel)
  }
}


extension StudyReviewVC {
  static func pushStudyReviewVC(viewController: UIViewController, studyDocumentID: String) {
    StudyService.getQnaList(studyDocumentID: studyDocumentID, completion: {
      (study, qnas) in
      let vc = StudyReviewVC(study: study, qnas: qnas)
      viewController.navigationController?.pushViewController(vc, animated: true)
    })
  }
}
