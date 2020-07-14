//
//  InProcessStudyVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class InProcessStudyVC: ViewController<InProcessView> {
  
  private var player: AVPlayer?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupPlayer()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print(#function)
    setupPlayerLayer()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    player?.play()
  }
  
  private func setupAsset() -> AVAsset? {
    guard let filePath = Bundle.main.path(forResource: "test", ofType: "mov") else { return nil }
    let videoURL = URL(fileURLWithPath: filePath)
    let asset = AVAsset(url: videoURL)
    return asset
  }
  
  private func setupPlayer() {
    guard let asset = setupAsset() else { return }
    let playerItem = AVPlayerItem(asset: asset)
    self.player = AVPlayer(playerItem: playerItem)
    
  }
  
  private func setupPlayerLayer() {
    let playerLayer = AVPlayerLayer(player: self.player)
    customView.addPlayerLayer(playerLayer: playerLayer)
  }
}
