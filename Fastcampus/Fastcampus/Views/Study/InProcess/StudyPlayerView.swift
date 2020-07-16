//
//  StudyPlayerView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol StudyPlayerViewDelegate: class {
  func screenMode(_ sender: UIButton)
  func question(_ sender: UIButton)
}

class StudyPlayerView: View {
  
  weak var delegate: StudyPlayerViewDelegate?
  
  private var pins: [UIView] = []
  
  private var playerLayer: CALayer?
  
  private let questionButton = UIButton()
  private let screenModeButton = UIButton()
  
  private let informationView = UIView()
  private let informationBackgroundView = UIView()
  private let slider = UISlider()
  private let restTimeLabel = UILabel()
  
  private let videoView = UIView()
  
  private var informationViewIsHidden = true {
    didSet {
      informationViewSwitchAnimation(isHidden: self.informationViewIsHidden)
    }
  }

  // MARK: Setup
  
  override func attribute() {
    super.attribute()
    backgroundColor = .black
    
    informationBackgroundView.backgroundColor = .black
    informationBackgroundView.alpha = 0.5
    
    questionButton.setImage(UIImage(systemName: "lightbulb"), for: .normal)
    questionButton.tintColor = .blue
    
    screenModeButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
    screenModeButton.setImage(UIImage(systemName: "square"), for: .selected)
    
    restTimeLabel.text = "00:00:00"
    restTimeLabel.textColor = .white
    restTimeLabel.font = .systemFont(ofSize: 12)
    
    slider.setThumbImage(UIImage(), for: .normal)
    slider.isEnabled = false
    slider.maximumTrackTintColor = .white
    slider.minimumTrackTintColor = .red
    
    questionButton.addTarget(self, action: #selector(didTapQuestionButton(_:)), for: .touchUpInside)
    screenModeButton.addTarget(self, action: #selector(didTapSreenModebutton(_:)), for: .touchUpInside)
    
  }
  
  override func setupUI() {
    super.setupUI()
    [videoView, informationView].forEach({
      addSubview($0)
    })
    
    [informationBackgroundView, questionButton, screenModeButton, slider, restTimeLabel].forEach({
      informationView.addSubview($0)
    })
    
    informationBackgroundView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview()
    })
    
    videoView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview()
    })
    
    
    let margin: CGFloat = 8
    let progressMargin: CGFloat = 4
    
    informationView.snp.makeConstraints({
      $0.top.bottom.leading.trailing.equalToSuperview()
    })
    informationBackgroundView.snp.makeConstraints({
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
      $0.bottom.equalToSuperview().offset(-margin)
      $0.trailing.equalTo(screenModeButton.snp.leading).offset(-margin)
    })
    
    slider.snp.makeConstraints({
      $0.leading.equalToSuperview().offset(margin)
      $0.trailing.equalTo(restTimeLabel.snp.leading).offset(-progressMargin)
      $0.centerY.equalTo(restTimeLabel)
    })
    
  }
  
  func configure(maximumTime: Int64, layer: CALayer) {
    slider.maximumValue = Float(maximumTime)
    guard playerLayer == nil else { return }
    playerLayer = layer
    videoView.layer.addSublayer(layer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer?.frame = videoView.frame
  }
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
  }
  
  // MARK: Action
  
  @objc private func didTapQuestionButton(_ sender: UIButton) {
    delegate?.question(sender)
  }
  
  @objc private func didTapSreenModebutton(_ sender: UIButton) {
    delegate?.screenMode(sender)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    informationViewIsHidden.toggle()
  }
  
  // 재생 정보 창 애니메이션
  private func informationViewSwitchAnimation(isHidden: Bool) {
    let alpha: CGFloat = isHidden ? 0: 1
    UIView.animate(withDuration: 0.2, animations: {
      [weak self] in
      self?.informationView.alpha = alpha
    })
  }
  
  func updatePlaySection(time: Int64) {
    let value = Float(time)
    slider.setValue(value, animated: true)
    restTimeLabel.text = Double(slider.maximumValue - value).toTimeString
  }
  
  func updatePins(_ qnas: [QnAModel]) {
    
    pins.forEach({
      $0.removeFromSuperview()
    })
    qnas.forEach({
      addPin($0.playTime)
    })
  }
  
  private func addPin(_ playTime: Int64) {
    let imageView = UIImageView(image: UIImage(systemName: "mappin"))
    let multiplied = CGFloat(playTime) / CGFloat(slider.maximumValue)
    slider.addSubview(imageView)
    print(multiplied)
    imageView.snp.makeConstraints({
      $0.bottom.equalTo(slider.snp.top)
      $0.centerX.equalTo(slider.snp.trailing).multipliedBy(multiplied)
    })
  }
  
}
