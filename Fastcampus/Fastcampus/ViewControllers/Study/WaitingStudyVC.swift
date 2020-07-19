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
  
  private var model: Study
  private var timer: Timer?
  
  init(study: Study) {
    self.model = study
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
    self.navigationController?.isNavigationBarHidden = false
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    stopTimer()
  }
  
  private func setNavigation() {
    self.title = "입장 대기"
    self.navigationItem.largeTitleDisplayMode = .never
    setBackButton(selector: #selector(popViewController(sender:)))
  }
  
  private func attribute() {
    setNavigation()
    customView.updateContent(study: model.data)
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
    let timeInterval = model.data.date.dateValue().timeIntervalSince(Date())
    
    guard timeInterval > 0 else {
      customView.updateTimer(timeInterval: timeInterval)
      stopTimer()
      pushInProcessStudyVC()
      return
    }
    
    customView.updateTimer(timeInterval: timeInterval)
  }
  
  private func pushInProcessStudyVC() {
    let vc = InProcessStudyVC(study: self.model)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc private func popViewController(sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
}

