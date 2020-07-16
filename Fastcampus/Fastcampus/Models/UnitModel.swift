//
//  UnitModel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct UnitModel: Codable {
  let title: String
  let index: Int
  let userIDs: [String]
  let studyIDs: [String]
  let memoIDs: [String]
}
