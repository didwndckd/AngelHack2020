//
//  InProcessView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit


protocol InProcessViewDelegate: StudyPlayerViewDelegate {
  
}

class InProcessView: StudyFrameView<StudyPlayerView, UITableView> {
  
  private weak var delegate: InProcessViewDelegate?
  
  override func attribute() {
    super.attribute()
    bringSubviewToFront(headerView)
    bodyView.backgroundColor = #colorLiteral(red: 0.8064444661, green: 0.8065617681, blue: 0.8240631223, alpha: 1)
    bodyView.separatorStyle = .none
    
    bodyView.register(QuestionCell.self, forHeaderFooterViewReuseIdentifier: QuestionCell.identifier)
  }
  
  override func setupUI() {
    super.setupUI()
  }
  
  func configurePlayerView(maximumValue: Int64, layer: CALayer) {
    headerView.configure(maximumTime: maximumValue, layer: layer)
  }
  
  func setupDelegate(vc: StudyPlayerViewDelegate & UITableViewDelegate & UITableViewDataSource) {
    bodyView.dataSource = vc
    bodyView.delegate = vc
    headerView.delegate = vc
  }
  
  
  // MARK: Action
  func updatePlaySection(time: Int64) {
    headerView.updatePlaySection(time: time)
  }
  
  func switchScreenMode(isFull: Bool) {
    if isFull {
      changeFullScreen()
    } else {
      changeMiniScreen()
    }
  }
  
  private func changeFullScreen() {
    bringSubviewToFront(headerView)
    headerView.snp.remakeConstraints({
      $0.leading.top.trailing.bottom.equalToSuperview()
    })
    self.layoutIfNeeded()
  }
  
  private func changeMiniScreen() {
    headerView.snp.remakeConstraints({
      let guide = safeAreaLayoutGuide
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.3)
    })
    self.layoutIfNeeded()
  }
  
  func reloadData(_ qnas: [QnAModel]) {
    bodyView.reloadData()
    headerView.updatePins(qnas)
  }
  
}
