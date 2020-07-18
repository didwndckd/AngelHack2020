//
//  QnAModel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase

struct QnA {
  let documentID: String
  let data: QnAModel
}

struct Qna {
  let documentID: String
  let data: QnAModel
}

struct QnAModel: Codable {
  let studyDocumentID: String
  let playTime: Int64
  let title: String
  let userID: String
  var isDone: Bool
//  var selectedMessageID
}

struct MessageModel: Codable {
  let date: Timestamp
  let userID: String
  let message: String
  
  var dateValue: Date { date.dateValue() }
}
