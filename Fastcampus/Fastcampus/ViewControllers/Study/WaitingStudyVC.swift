//
//  WaitingStudyVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WaitingStudyVC: ViewController<WaitingView> {
  
  typealias UnitInformation = (title: String, content: String)
  
  private var study: Study
  private var timer: Timer?
  
  init(study: Study) {
    self.study = study
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    // test용 함수 호출
    pushInProcessStudyVC()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    stopTimer()
  }
  
  private func attribute() {
    self.title = study.title
    self.navigationItem.largeTitleDisplayMode = .never
    customView.updateContent(study: study)
  }
  
  private func startTimer() {
    if let timer = self.timer, !timer.isValid {
      self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerCallBack(_:)), userInfo: nil, repeats: true)
    } else {
      self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerCallBack(_:)), userInfo: nil, repeats: true)
    }
  }
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  @objc private func timerCallBack(_ sender: Timer) {
    let timeInterval = study.date.timeIntervalSince(Date())
    
    guard timeInterval > 0 else {
      customView.updateTimer(timeInterval: timeInterval)
      stopTimer()
      return
    }
    
    customView.updateTimer(timeInterval: timeInterval)
  }
  
  private func pushInProcessStudyVC() {
    let vc = InProcessStudyVC()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
  
}

