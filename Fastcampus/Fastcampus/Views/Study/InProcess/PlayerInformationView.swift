//
//  PlayerInformationView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class PlayerInformationView: View {

  private let backgroundView = UIView()
  private let questionButton = UIButton()
  private let progressView = PlayerProgressView()
  private let screenModeButton = UIButton()
  
  
  override func attribute() {
    super.attribute()
    backgroundView.backgroundColor = .black
    backgroundView.alpha = 0.2
    
    questionButton.setImage(UIImage(systemName: "lightbulb"), for: .normal)
    questionButton.tintColor = .blue
    
    screenModeButton.setImage(UIImage(systemName: "square"), for: .normal)
    screenModeButton.setImage(UIImage(systemName: "square.fill"), for: .selected)
    
  }
  
  override func setupUI() {
    super.setupUI()
    
    [backgroundView, questionButton, progressView, screenModeButton].forEach({
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    })
    
    let margin: CGFloat = 8
    
    backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    screenModeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
    screenModeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    
    progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
    progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
    progressView.trailingAnchor.constraint(equalTo: screenModeButton.leadingAnchor, constant: -margin).isActive = true
    
    questionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
    questionButton.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -margin).isActive = true
    
  }
  
}
