//
//  PlayerProgressView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class PlayerProgressView: View {

  let progressBar = UIProgressView()
  let remainingTimeLabel = UILabel()
  
  override func attribute() {
    remainingTimeLabel.text = "00:00:00"
    progressBar.tintColor = .red
    progressBar.setProgress(0.5, animated: true)
  }
  
  override func setupUI() {
    super.setupUI()
    [progressBar, remainingTimeLabel].forEach({
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    })
    let margin: CGFloat = 4
    
    remainingTimeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    remainingTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    progressBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    progressBar.centerYAnchor.constraint(equalTo: remainingTimeLabel.centerYAnchor).isActive = true
    progressBar.trailingAnchor.constraint(equalTo: remainingTimeLabel.leadingAnchor, constant: -margin).isActive = true
    
  }

}
