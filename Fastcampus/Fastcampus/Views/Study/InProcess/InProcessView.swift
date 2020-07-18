//
//  InProcessView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit


protocol InProcessViewDelegate: StudyPlayerViewDelegate {
  func question(_ sender: UIButton)
}

class InProcessView: View {
  
  private weak var delegate: InProcessViewDelegate?
  
  private let playerView = StudyPlayerView()
  private let questionTableView = UITableView()
  private let questionButton = QuestionButton()
  private let bodyView = UIView()
  
  override func attribute() {
    super.attribute()
    bringSubviewToFront(playerView)
    questionTableView.backgroundColor = #colorLiteral(red: 0.8064444661, green: 0.8065617681, blue: 0.8240631223, alpha: 1)
    questionTableView.separatorStyle = .none
    
    questionTableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)
    questionButton.addTarget(self, action: #selector(didTapQuestionButton(_:)), for: .touchUpInside)
  }
  
  override func setupUI() {
    super.setupUI()
    [playerView, bodyView].forEach({
      addSubview($0)
    })
    [questionTableView, questionButton].forEach({
      bodyView.addSubview($0)
    })
    
    let guide = safeAreaLayoutGuide
    
    playerView.snp.makeConstraints({
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.3)
    })
    
    bodyView.snp.makeConstraints({
      $0.bottom.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.7)
    })
    
    questionButton.snp.makeConstraints({
      $0.top.leading.trailing.equalToSuperview()
    })
    
    questionTableView.snp.makeConstraints({
      $0.top.equalTo(questionButton.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    })
    
  }
  
  func configurePlayerView(maximumValue: Int64, layer: CALayer) {
    playerView.configure(maximumTime: maximumValue, layer: layer)
  }
  
  func setupDelegate(vc: InProcessViewDelegate & UITableViewDelegate & UITableViewDataSource) {
    questionTableView.dataSource = vc
    questionTableView.delegate = vc
    playerView.delegate = vc
    self.delegate = vc
  }
  
  
  // MARK: Action
  func updatePlaySection(time: Int64) {
    playerView.updatePlaySection(time: time)
  }
  
  func switchScreenMode(isFull: Bool) {
    if isFull {
      changeFullScreen()
    } else {
      changeMiniScreen()
    }
  }
  
  private func changeFullScreen() {
    bringSubviewToFront(playerView)
    let guide = safeAreaLayoutGuide
    backgroundColor = .black
    playerView.snp.remakeConstraints({
      $0.leading.top.trailing.bottom.equalTo(guide)
    })
    self.layoutIfNeeded()
  }
  
  private func changeMiniScreen() {
    backgroundColor = .white
    playerView.snp.remakeConstraints({
      let guide = safeAreaLayoutGuide
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.3)
    })
    self.layoutIfNeeded()
  }
  
  func reloadData(_ qnas: [QnA]) {
    questionTableView.reloadData()
    playerView.updatePins(qnas)
  }
  
  @objc private func didTapQuestionButton(_ sender: UIButton) {
    delegate?.question(sender)
  }
  
  func tableViewBottomScroll(row: Int) {
    questionTableView.scrollToRow(at: (IndexPath(row: row, section: 0)), at: .bottom, animated: true)
  }
}
