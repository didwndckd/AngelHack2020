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
  private let screenModeButton = UIButton()
  
  private let slider = UISlider()
  private let restTimeLabel = UILabel()
  
  var isAppear = false {
    didSet {
      appearAnimation(isAppear: self.isAppear)
    }
  }
  
  // MARK: Setup
  override func attribute() {
    super.attribute()
    backgroundColor = .clear
    backgroundView.backgroundColor = .black
    backgroundView.alpha = 0.5
    
    questionButton.setImage(UIImage(systemName: "lightbulb"), for: .normal)
    questionButton.tintColor = .blue
    
    screenModeButton.setImage(UIImage(systemName: "square"), for: .normal)
    screenModeButton.setImage(UIImage(systemName: "square.fill"), for: .selected)
    
    restTimeLabel.text = "00:00:00"
    restTimeLabel.textColor = .white
    restTimeLabel.font = .systemFont(ofSize: 12)
    
    slider.setThumbImage(UIImage(), for: .normal)
    slider.isEnabled = false
    slider.maximumTrackTintColor = .white
    slider.minimumTrackTintColor = .red
  }
  
  override func setupUI() {
    super.setupUI()
    
    [backgroundView, questionButton, screenModeButton, slider, restTimeLabel].forEach({
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    })
    
    let margin: CGFloat = 8
    let progressMargin: CGFloat = 4
    
    backgroundView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview()
    })
    
    screenModeButton.snp.makeConstraints({
      $0.bottom.equalToSuperview().offset(-margin)
      $0.trailing.equalToSuperview().offset(-margin)
    })
    
    questionButton.snp.makeConstraints({
      $0.leading.equalToSuperview().offset(margin)
      $0.bottom.equalTo(screenModeButton.snp.top).offset(-margin)
    })
    
    restTimeLabel.snp.makeConstraints({
      $0.bottom.equalToSuperview().offset(-progressMargin)
      $0.trailing.equalTo(screenModeButton.snp.leading).offset(-margin)
    })
    
    slider.snp.makeConstraints({
      $0.leading.equalToSuperview().offset(margin)
      $0.trailing.equalTo(restTimeLabel.snp.leading).offset(-progressMargin)
      $0.centerY.equalTo(restTimeLabel)
    })
  }
  
  
  func configure(maximumValue: Int64) {
    slider.maximumValue = Float(maximumValue)
  }
  
  // MARK: Action
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    isAppear = false
  }
  
  private func appearAnimation(isAppear: Bool) {
    let alpha: CGFloat = isAppear ? 1: 0
    UIView.animate(withDuration: 0.2, animations: {
      [weak self] in
      self?.alpha = alpha
    })
  }
  
  func updatePlaySection(time: Int64) {
    let value = Float(time)
    slider.setValue(value, animated: true)
    restTimeLabel.text = Double(slider.maximumValue - value).toTimeString
  }
  
  
}
