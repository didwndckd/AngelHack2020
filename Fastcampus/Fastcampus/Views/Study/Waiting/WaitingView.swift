//
//  WaitingView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WaitingView: View {
  
  private let headerView = TimerView()
  private let bodyView = WaitingStudyContentView()
  
  override func setupUI() {
    super.setupUI()
    
    [headerView, bodyView].forEach({
      addSubview($0)
    })
    
    let guide = safeAreaLayoutGuide
    let topMargin: CGFloat = 32
    
    headerView.snp.makeConstraints({
      $0.top.equalTo(guide).offset(topMargin)
      $0.centerX.equalTo(guide)
      $0.width.equalTo(guide).multipliedBy(0.6)
      $0.height.equalTo(headerView.snp.width)
    })
    
    bodyView.snp.makeConstraints({
      $0.top.equalTo(headerView.snp.bottom).offset(topMargin)
      $0.leading.trailing.bottom.equalTo(guide)
    })
    
  }
  
  func updateTimer(timeInterval: Double) {
    headerView.configure(timeInterval: timeInterval)
  }
  
  func updateContent(study: StudyModel) {
    headerView.configure(startTime: study.dateValue)
    bodyView.configure(study: study)
  }
  
}
