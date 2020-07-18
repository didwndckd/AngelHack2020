//
//  Lecture.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct Lecture: Codable {
  let id: Int
  let title: String
  let imageURL: String
  let type: String
  let chapters: [ChapterModel]?
  let documentID: String
}
