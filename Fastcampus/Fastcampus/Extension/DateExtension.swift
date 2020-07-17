//
//  DateExtension.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

extension Date {
  func dateToString(format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}
