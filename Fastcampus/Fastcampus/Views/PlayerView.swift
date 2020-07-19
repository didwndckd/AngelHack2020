//
//  PlayerView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol PlayerControl: StudyPlayerViewDelegate {
  func startSlide()
  func endSlide()
  func slide(_ value: Float)
  func play(isPlay: Bool)
  func slip()
  func rewind()
}

class PlayerView: StudyPlayerView {
  
  weak var controller: PlayerControl?
  
  private let playButton = UIButton()
  private let slipButton = UIButton()
  private let rewindButton = UIButton()
  
  override func attribute() {
    super.attribute()
//    let inset: CGFloat = 8
    playButton.setImage(UIImage(systemName: "play"), for: .normal)
    playButton.setImage(UIImage(systemName: "pause"), for: .selected)
    playButton.tintColor = .white
//    playButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    playButton.contentVerticalAlignment = .fill
    playButton.contentHorizontalAlignment = .fill
    playButton.addTarget(self, action: #selector(didTapPlayButton(_:)), for: .touchUpInside)
    
    slipButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
    slipButton.tintColor = .white
//    slipButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    slipButton.contentVerticalAlignment = .fill
    slipButton.contentHorizontalAlignment = .fill
    slipButton.addTarget(self, action: #selector(didTapslipButton(_:)), for: .touchUpInside)
    
    rewindButton.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
    rewindButton.tintColor = .white
//    rewindButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    rewindButton.contentVerticalAlignment = .fill
    rewindButton.contentHorizontalAlignment = .fill
    rewindButton.addTarget(self, action: #selector(didTapRewindButton(_:)), for: .touchUpInside)
    
    slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
    slider.tintColor = .white
    slider.isEnabled = true
    slider.addTarget(self, action: #selector(sliderChangeValue(_:)), for: .valueChanged)
    slider.addTarget(self, action: #selector(startSlide), for: .touchDown)
    slider.addTarget(self, action: #selector(endSlide), for: .touchUpInside)
    slider.addTarget(self, action: #selector(endSlide), for: .touchUpOutside)
  }
  
  override func setupUI() {
    super.setupUI()
    [playButton, slipButton, rewindButton].forEach({
      informationView.addSubview($0)
    })
    
    playButton.snp.makeConstraints({
      $0.center.equalToSuperview()
      $0.width.height.equalTo(30)
    })
    
    rewindButton.snp.makeConstraints({
      $0.centerY.equalToSuperview()
      $0.centerX.equalToSuperview().multipliedBy(0.4)
      $0.width.height.equalTo(30)
    })
    
    slipButton.snp.makeConstraints({
      $0.centerY.equalToSuperview()
      $0.centerX.equalToSuperview().multipliedBy(1.6)
      $0.width.height.equalTo(30)
    })
    
  }
  
  @objc private func didTapPlayButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    controller?.play(isPlay: !sender.isSelected)
    
  }
  
  @objc private func didTapslipButton(_ sender: UIButton) {
    controller?.slip()
  }
  
  @objc private func didTapRewindButton(_ sender: UIButton) {
    controller?.rewind()
  }
  
  @objc private func sliderChangeValue(_ sender: UISlider) {
    controller?.slide(sender.value)
  }
  
  @objc private func endSlide() {
    controller?.endSlide()
  }
  
  @objc private func startSlide() {
    controller?.startSlide()
  }
}
