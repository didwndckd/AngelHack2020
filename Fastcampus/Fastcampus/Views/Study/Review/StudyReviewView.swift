//
//  StudyReviewView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol StudyReviewViewDelegate: UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
  
}

class StudyReviewView: View {
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    if view == questionCollectionView || view == chattingTableView {
      endEditing(true)
    }
    return view
  }

  private let questionCollectionView: UICollectionView
  private let chattingTableView = UITableView()
  private let editingView = ChattingInpuView()
  var collectionViewItemSize: CGFloat {
    questionCollectionView.bounds.width - (8 * 2)
  }
  
  // MARK: Setup
  
  override init(frame: CGRect) {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    self.questionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func attribute() {
    super.attribute()
    questionCollectionView.backgroundColor = .myGray
    questionCollectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: QuestionCollectionViewCell.idenifier)
    
    questionCollectionView.decelerationRate = .fast
  }
  
  override func setupUI() {
    super.setupUI()
    [questionCollectionView, chattingTableView, editingView].forEach({
      addSubview($0)
    })
    
    let guide = safeAreaLayoutGuide
    
    questionCollectionView.snp.makeConstraints({
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.4)
    })
    
    chattingTableView.snp.makeConstraints({
      $0.top.equalTo(questionCollectionView.snp.bottom)
      $0.leading.trailing.equalTo(guide)
    })
    
    editingView.snp.makeConstraints({
      $0.top.equalTo(chattingTableView.snp.bottom)
      $0.leading.trailing.bottom.equalTo(guide)
      $0.height.equalTo(48)
    })
    
  }
  
  func setDelegate(delegate: StudyReviewViewDelegate) {
    questionCollectionView.delegate = delegate
    questionCollectionView.dataSource = delegate
    chattingTableView.dataSource = delegate
    chattingTableView.delegate = delegate
  }
  
  
  // MARK: Action
  
  func switchEditingMode(isEditing: Bool, height: CGFloat) {
    if isEditing {
      editingMode(hedight: height)
    } else {
      endEditinMode()
    }
  }
  
  private func editingMode(hedight: CGFloat) {
    let guide = safeAreaLayoutGuide
    editingView.snp.remakeConstraints({
      $0.top.equalTo(chattingTableView.snp.bottom)
      $0.leading.trailing.equalTo(guide)
      $0.bottom.equalTo(guide).offset(-(hedight - safeAreaInsets.bottom) )
      $0.height.equalTo(48)
    })
    layoutIfNeeded()
  }
  
  private func endEditinMode() {
    let guide = safeAreaLayoutGuide
    editingView.snp.remakeConstraints({
      $0.top.equalTo(chattingTableView.snp.bottom)
      $0.leading.trailing.bottom.equalTo(guide)
      $0.height.equalTo(48)
    })
    layoutIfNeeded()
  }
  
  
  
}
