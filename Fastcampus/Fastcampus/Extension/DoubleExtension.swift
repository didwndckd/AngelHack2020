//
//  DoubleExtension.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

extension Double {
  var remainingTime: String {
    let interval = Int(self)
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
