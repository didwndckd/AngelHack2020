//
//  StudyReViewVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyReviewVC: ViewController<StudyReviewView>, KeyboardObserving, StudyReviewViewDelegate {
  
  private var model: [QnA]
  private var chat: [MessageModel] = [] {
    didSet {
      
    }
  }
  
  init(qnas: [QnA]) {
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
    customView.setDelegate(delegate: self)
    
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.idenifier, for: indexPath) as! QuestionCollectionViewCell
    cell.configure(qna: model[indexPath.row].data, index: indexPath.row, count: model.count)
    return cell
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let cellWidthIncludingSpacing = customView.collectionViewItemSize + 8
    let offset = scrollView.contentOffset
    let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    print(index)
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
    
    let cellWidthIncludingSpacing = customView.collectionViewItemSize + 8
    
//    print("cellWidthIncludingSpacing", cellWidthIncludingSpacing)
    
    // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
    // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
    var offset = targetContentOffset.pointee
    let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    var roundedIndex = round(index)
//    print("index", index)
    
    
    // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
    // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
    // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
    if scrollView.contentOffset.x > targetContentOffset.pointee.x {
      roundedIndex = floor(index)
    } else {
      roundedIndex = ceil(index)
    }
//    print("roundedIndex", roundedIndex)
    
    // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offset
//    print("offset", offset)
    
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
    let margin: CGFloat = 8
    let inset: CGFloat = 8
    let height = collectionView.bounds.height - (inset * 2)
    let width = collectionView.bounds.width - (margin * 2)
    return CGSize(width: width, height: height)
  }
}


extension StudyReviewVC {
  static func pushStudyReviewVC(viewController: UIViewController, studyDocumentID: String) {
    StudyService.getQnaList(studyDocumentID: studyDocumentID, completion: {
      qnas in
      let vc = StudyReviewVC(qnas: qnas)
      viewController.navigationController?.pushViewController(vc, animated: true)
    })
  }
}
