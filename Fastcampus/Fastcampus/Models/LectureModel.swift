//
//  LectureModel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct LectureModel: Codable {
  let documentID: String
  let title: String
  let imageURL: String
  let chapters: [ChapterModel]
}

