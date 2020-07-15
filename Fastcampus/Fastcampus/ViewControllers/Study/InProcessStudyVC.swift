//
//  InProcessStudyVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import AVFoundation

class InProcessStudyVC: ViewController<InProcessView> {
  
  private var player: AVPlayer?
  private var timeObserverToken: Any?
  private var duration: Int64 = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPlayer()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupPlayerView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    player?.play()
    addTimeObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    removeTimeObserver()
  }
  
  private func setupAsset() -> AVAsset? {
    guard let filePath = Bundle.main.path(forResource: "test", ofType: "mov") else { return nil }
    let videoURL = URL(fileURLWithPath: filePath)
    let asset = AVAsset(url: videoURL)
    self.duration = asset.duration.value / Int64(asset.duration.timescale)
    return asset
  }
  
  private func setupPlayer() {
    guard let asset = setupAsset() else { return }
    let playerItem = AVPlayerItem(asset: asset)
    self.player = AVPlayer(playerItem: playerItem)
  }
  
  private func setupPlayerView() {
    let playerLayer = AVPlayerLayer(player: self.player)
    customView.configurePlayerView(maximumValue: duration, layer: playerLayer)
  }
  
  private func addTimeObserver() {
    let timeScale = CMTimeScale(NSEC_PER_SEC)
    let interval = CMTime(seconds: 0.5, preferredTimescale: timeScale)
    timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: {
      [weak self] time in
      guard let self = self else { return }
      let currentTime = time.value / Int64(time.timescale)
      self.customView.updatePlaySection(time: currentTime)
    })
  }
  
  private func removeTimeObserver() {
    guard let token = timeObserverToken else { return }
    player?.removeTimeObserver(token)
    timeObserverToken = nil
    print(#function)
  }
  
}
