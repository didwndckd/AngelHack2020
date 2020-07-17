//
//  WaitingStudyVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

class WaitingStudyVC: ViewController<WaitingView> {
  
  typealias UnitInformation = (title: String, content: String)
  
  private var model: StudyModel
  private var timer: Timer?
  
  init(studyModel: StudyModel) {
    self.model = studyModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
//    pushInProcessStudyVC()
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
    self.title = model.title
    self.navigationItem.largeTitleDisplayMode = .never
    customView.updateContent(study: model)
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
    let timeInterval = model.date.dateValue().timeIntervalSince(Date())
    
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

