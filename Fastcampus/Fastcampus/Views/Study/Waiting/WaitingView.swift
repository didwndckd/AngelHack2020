//
//  WaitingView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WaitingView: StudyFrameView<TimerView, WaitingStudyContentView> {
  
    
  override func attribute() {
    super.attribute()
    
    
  }
  
  
  func updateTimer(timeInterval: Double) {
    headerView.configure(timeInterval: timeInterval)
  }
  
  func updateContent(study: StudyModel) {
    bodyView.configure(rule: study.rule, unitTitle: study.unitTitle, unitContent: study.unitDescription)
  }
  
}
