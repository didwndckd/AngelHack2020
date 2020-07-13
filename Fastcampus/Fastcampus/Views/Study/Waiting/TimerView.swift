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
    let ratingTime = isTimeOver ? intervalToString(interval: 0): intervalToString(interval: timeInterval)
    let textColor: UIColor = isTimeOver ? .red: .blue
    
    timerLabel.textColor = textColor
    timerLabel.text = ratingTime
  }
  
  private func intervalToString(interval: Double) -> String {
    let interval = Int(interval)
    let oneMinute = 60
    let oneHour = oneMinute * 60
    let oneday = oneHour * 24
    
    let days = interval / oneday
    let daysToString = days != 0 ? "\(days)일 ": ""
    
    let hours = (interval - (days * oneday)) / oneHour
    let hoursToString = hours < 10 ? "0\(hours)": "\(hours)"
    
    let minutes = (interval - (days * oneday) - (hours * oneHour)) / oneMinute
    let minuteToString = minutes < 10 ? "0\(minutes)": "\(minutes)"
    
    let sec = (interval - (days * oneday) - (hours * oneHour) - (minutes * oneMinute))
    let secToString = sec < 10 ? "0\(sec)": "\(sec)"

    let result = daysToString + hoursToString + ":" + minuteToString + ":" + secToString
    
    return result
  }
  
}
