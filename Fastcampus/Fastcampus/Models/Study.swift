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
  let Rule: String
  var userIDs: [String]
  var qnaIDs: [String]
  var inProcess: ProcessStatus
  
  enum ProcessStatus: Int, Codable {
    case wait
    case inProcess
    case finished
  }
  
}
