//
//  PlayerViewController.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import AVFoundation




class PlayerViewController: UIViewController {
  
  private var player: AVPlayer?
  private var timeObserverToken: Any?
  let playerView = PlayerView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPlayer()
    playerView.controller = self
    playerView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addObservers()
    player?.play()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    player?.pause()
    removeObservers()
    
  }
  
  private func setupAsset() -> AVAsset? {
    let fi = Bundle.main.path(forResource: "Lecture", ofType: "mov")
    print("==========================================================================")
    print("filePath: ", fi)
    guard let filePath = Bundle.main.path(forResource: "Lecture", ofType: "mov") else { return nil }
    print(filePath)
    let videoURL = URL(fileURLWithPath: filePath)
    let asset = AVAsset(url: videoURL)
    return asset
  }
  
  private func setupPlayer() {
    guard let asset = setupAsset() else { return }
    let playerItem = AVPlayerItem(asset: asset)
    let player = AVPlayer(playerItem: playerItem)
    let duration = asset.duration.value / Int64(asset.duration.timescale)
    self.player = player
    
    setupPlayerView(player: player, duration: duration)
  }
  
  private func setupPlayerView(player: AVPlayer, duration: Int64) {
    let playerLayer = AVPlayerLayer(player: player)
    playerView.configure(maximumTime: duration, layer: playerLayer)
  }
  
  private func addObservers() {
    addPlayerDidPlayToEndTimeObserver()
    addTimeObserver()
  }
  
  private func addPlayerDidPlayToEndTimeObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(endPlayer), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
  }
  
  private func addTimeObserver() {
    let timeScale = CMTimeScale(NSEC_PER_SEC)
    let interval = CMTime(seconds: 0.5, preferredTimescale: timeScale)
    timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: {
      [weak self] time in
      guard let self = self else { return }
      let currentTime = time.value / Int64(time.timescale)
      self.playerView.updatePlaySection(time: currentTime)
    })
  }
  
  private func removeTimeObserver() {
    guard let token = timeObserverToken else { return }
    player?.removeTimeObserver(token)
    timeObserverToken = nil
    print(#function)
  }
  
  private func removeObservers() {
    removeTimeObserver()
    NotificationCenter.default.removeObserver(self)
  }
 
  @objc private func endPlayer() {
    
  }
  
  private func seekPlayer(to: Int64) {
    let seekTime = CMTime(value: to * Int64(NSEC_PER_SEC), timescale: Int32(NSEC_PER_SEC))
    guard let player = player else { return }
    print(seekTime)
    player.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
  }
  
  private func setLotation(isFull: Bool) {
    let orientation: UIInterfaceOrientation = isFull ? .landscapeRight: .portrait
    let value = orientation.rawValue
    UIDevice.current.setValue(value, forKey: "orientation")
  }
  
  private func switchScreenMode(isFull: Bool) {
    if isFull {
      changeFullScreen()
    } else {
      changeMiniScreen()
    }
  }
  
  func changeFullScreen() {
  }
  
  func changeMiniScreen() {
  }
  
}

extension PlayerViewController: PlayerControl {
  func slide(_ value: Float) {
    seekPlayer(to: Int64(value))
  }
  
  func startSlide() {
    player?.pause()
  }
  
  func endSlide() {
    player?.play()
  }
  
  func play(isPlay: Bool) {
    if isPlay {
      player?.play()
    } else {
      player?.pause()
    }
  }
  
  func slip() {
    guard let currentTime = player?.currentTime() else { return }
    let value = currentTime.value / Int64(currentTime.timescale)
    seekPlayer(to: value + 10)
  }
  
  func rewind() {
    guard let currentTime = player?.currentTime() else { return }
    let value = currentTime.value / Int64(currentTime.timescale)
    seekPlayer(to: value - 10)
  }
  
  func screenMode(_ sender: UIButton) {
    sender.isSelected.toggle()
    navigationController?.setNavigationBarHidden(sender.isSelected, animated: true)
    
    UIView.animate(withDuration: 0.3, animations: {
      [weak self] in
      self?.switchScreenMode(isFull: sender.isSelected)
    })
    self.setLotation(isFull: sender.isSelected)
  }
  
  
}
