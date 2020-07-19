//
//  Summary.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct Summary: Codable {
  var documentID: String?
  let userID: String
  let unitID: Int
  let title: String
  let contents: String
  let isOpen: Bool
  let comments: [String]?
}
