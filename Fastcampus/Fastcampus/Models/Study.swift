//
//  Study.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import AVFoundation


struct Study: Codable {
  
  let id: Int
  let title: String
  let date: Date
  let rule: String
  var userIDs: [String]
  var qnaIDs: [String]
  var inProcess: ProcessStatus
  let unitTitle: String
  let unitContent: String
  
  enum ProcessStatus: Int, Codable {
    case wait
    case inProcess
    case finished
  }
  
}

