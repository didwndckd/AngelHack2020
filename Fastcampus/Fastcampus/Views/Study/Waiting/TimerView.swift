//
//  TimerView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class TimerView: View {
  private let guideLabel = UILabel()
  private let startTimeGuideLabel = UILabel()
  
  private let timerLabel = UILabel()
  private let backgroundView = CircleView()
  private let startTimeLabel = UILabel()
  private let borderWidth: CGFloat = 20
  
  
  override func attribute() {
    super.attribute()
    
    backgroundView.layer.borderWidth = borderWidth
    backgroundView.layer.borderColor = UIColor.myRed.cgColor
    
    guideLabel.font = .systemFont(ofSize: 16, weight: .bold)
    guideLabel.textColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.662745098, alpha: 1)
    guideLabel.textAlignment = .center
    guideLabel.text = "스터디 입장까지"
    
    timerLabel.textAlignment = .center
    timerLabel.font = .systemFont(ofSize: 33, weight: .bold)
    
    startTimeGuideLabel.font = .systemFont(ofSize: 12, weight: .regular)
    startTimeGuideLabel.textColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.662745098, alpha: 1)
    startTimeGuideLabel.textAlignment = .center
    startTimeGuideLabel.text = "시작 시간"
    
    startTimeLabel.font = .systemFont(ofSize: 16, weight: .regular)
    startTimeLabel.textColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.662745098, alpha: 1)
  }
  
  override func setupUI() {
    super.setupUI()
    addSubview(backgroundView)
    
    let margin: CGFloat = 4
    
    [guideLabel, timerLabel, startTimeLabel, startTimeGuideLabel].forEach({
      backgroundView.addSubview($0)
    })
    
    backgroundView.snp.makeConstraints({
      $0.width.equalTo(backgroundView.snp.height)
      $0.leading.trailing.top.bottom.equalToSuperview()
    })
    
    guideLabel.snp.makeConstraints({
      $0.bottom.equalTo(timerLabel.snp.top).offset(-margin)
      $0.centerX.equalToSuperview()
    })
    
    timerLabel.snp.makeConstraints({
      $0.center.equalToSuperview()
    })
    
    startTimeGuideLabel.snp.makeConstraints({
      $0.top.equalTo(timerLabel.snp.bottom).offset(margin)
      $0.centerX.equalToSuperview()
    })
    
    startTimeLabel.snp.makeConstraints({
      $0.top.equalTo(startTimeGuideLabel.snp.bottom).offset(margin)
      $0.centerX.equalToSuperview()
    })
  }
  
  func configure(timeInterval: Double) {
    let remainingTime = timeInterval <= 0 ? Double(0).toTimeString: timeInterval.toTimeString
    timerLabel.text = remainingTime
  }
  
  func configure(startTime: Date) {
    let startTime = startTime.dateToString(format: "MM.dd HH:mm")
    startTimeLabel.text = startTime
  }
}
