//
//  StudyPlayerView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit


class StudyPlayerView: View {
  
  private let informationView = PlayerInformationView()
  private let videoView = UIView()

  // MARK: Setup
  
  override func attribute() {
    super.attribute()
    backgroundColor = .black
  }
  
  override func setupUI() {
    super.setupUI()
    [videoView, informationView].forEach({
      addSubview($0)
    })
    
    
    informationView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview()
    })
    
    videoView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview()
    })
  }
  
  func configure(maximumTime: Int64, layer: CALayer) {
    layer.frame = videoView.bounds
    videoView.layer.addSublayer(layer)
    
    informationView.configure(maximumValue: maximumTime)
  }
  
  // MARK: Action
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    informationView.isAppear = true
  }
  
  func updatePlaySection(time: Int64) {
    informationView.updatePlaySection(time: time)
  }
    
}
