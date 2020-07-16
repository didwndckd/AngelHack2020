//
//  ChapterModel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct ChapterModel: Codable {
  let title: String
  let index: Int
  let Units: [UnitModel]
}
