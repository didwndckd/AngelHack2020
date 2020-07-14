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

  override func attribute() {
    super.attribute()
    
  }
  
  override func setupUI() {
    super.setupUI()
    [informationView].forEach({
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    })
    
    informationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    informationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    informationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    informationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
  }
  
  
    
}
