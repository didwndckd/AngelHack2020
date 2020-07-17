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
  private var qnas: [QnAModel] = [] {
    didSet {
      customView.reloadData(self.qnas)
    }
  }
  var count = 0
  
  // MARK: Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPlayer()
    customView.setupDelegate(vc: self)
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
  
  
  private func setupQnAModel() {
    
  }
  
  // MARK: Action
  
  
  private func setLotation(isFull: Bool) {
    let orientation: UIInterfaceOrientation = isFull ? .landscapeRight: .portrait
    let value = orientation.rawValue
    UIDevice.current.setValue(value, forKey: "orientation")
  }
  
}

// MARK: InProcessStudyViewDelegate

extension InProcessStudyVC: InProcessViewDelegate {
  func screenMode(_ sender: UIButton) {
    sender.isSelected.toggle()
    navigationController?.setNavigationBarHidden(sender.isSelected, animated: true)
    
    UIView.animate(withDuration: 0.3, animations: {
      [weak self] in
      self?.customView.switchScreenMode(isFull: sender.isSelected)
    })
    self.setLotation(isFull: sender.isSelected)
    
  }
  
  
  func question(_ sender: UIButton) {
    alertSingleTextField(message: "질문 내용", actionTitle: "확인", completion: {
      [weak self] title in
      guard let title = title else { return }
      self?.addQustion(title)
    })
  }
  
  private func addQustion(_ title: String) {
  
    guard let playCMTime = player?.currentTime() else { return }
    
    let playTime = playCMTime.value / Int64(playCMTime.timescale)
    let qna = QnAModel(
      documentID: "documentid: \(count)",
      playTime: playTime,
      title: title,
      userID: "userID \(count)",
      isDone: false,
      messages: []
    )
    qnas.append(qna)
    count += 1
    
  }
  
  
}

// MARK: UITableViewDataSource

extension InProcessStudyVC: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    qnas.count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: QuestionCell.identifier) as! QuestionCell
    headerView.configure(qna: qnas[section])
    return headerView
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    qnas[section].messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
}

// MARK: UITableViewDelegate
extension InProcessStudyVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return tableView.bounds.height / 1.5
  }
}

