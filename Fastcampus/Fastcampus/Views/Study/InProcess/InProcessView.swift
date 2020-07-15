//
//  InProcessView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class InProcessView: StudyFrameView<StudyPlayerView, UITableView> {
  
  func updatePlaySection(time: Int64) {
    headerView.updatePlaySection(time: time)
  }
  func configurePlayerView(maximumValue: Int64, layer: CALayer) {
    headerView.configure(maximumTime: maximumValue, layer: layer)
  }
    
}
