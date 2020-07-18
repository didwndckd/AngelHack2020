//
//  StudyReviewView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyReviewView: View {

  private let questionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let chattingTableView = UITableView()
  private let editingView = ChattingInpuView()
  
  
  override func attribute() {
    super.attribute()
    questionCollectionView.backgroundColor = .blue
    chattingTableView.backgroundColor = .red
    
  }
  
  override func setupUI() {
    super.setupUI()
    [questionCollectionView, chattingTableView, editingView].forEach({
      addSubview($0)
    })
    
    let guide = safeAreaLayoutGuide
    
    questionCollectionView.snp.makeConstraints({
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.3)
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
  
  
  
  
}
