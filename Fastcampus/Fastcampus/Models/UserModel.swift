//
//  UserModel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct UserModel: Codable {
  let nickName: String
  let level: Int
  let lectures: [String]
  var studys: [String]
  let uid: String
}
 
