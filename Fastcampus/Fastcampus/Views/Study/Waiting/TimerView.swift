//
//  TimerView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class TimerView: View {
  
  private let timerLabel = UILabel()
  
  override func attribute() {
    super.attribute()
    
    timerLabel.textAlignment = .center
    timerLabel.font = .systemFont(ofSize: 30, weight: .bold)
  }
  
  override func setupUI() {
    super.setupUI()
    
    addSubview(timerLabel)
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    
    timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    timerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
  }
  
  func configure(timeInterval: Double) {
    let isTimeOver = timeInterval <= 0
    let remainingTime = isTimeOver ? Double(0).toTimeString: timeInterval.toTimeString
    let textColor: UIColor = isTimeOver ? .red: .blue
    
    timerLabel.textColor = textColor
    timerLabel.text = remainingTime
  }
  
  
}
