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
  private var model: Study
  
  private var qnas: [QnA] = [] {
    didSet {
      customView.reloadData(self.qnas)
    }
  }
  
  init(study: Study) {
    self.model = study
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPlayer()
    customView.setupDelegate(vc: self)
    setNavigation()
    setupQnAModel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let interval = Date().timeIntervalSince(model.data.dateValue)
    seekPlayer(to: Int64(interval))
    addObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    player?.pause()
    removeObservers()
    
    StudyService.qnaListenerRemove()
  }
  
  private func setNavigation() {
    navigationItem.setTitle(model.data.lectureTitle, subtitle: model.data.unitTitle)
    setBackButton(selector: #selector(popRootViewController(sender:)))
  }
  
  private func setupAsset() -> AVAsset? {
    guard let filePath = Bundle.main.path(forResource: "Study", ofType: "MP4") else { return nil }
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
  
  private func addObservers() {
    addPlayerDidPlayToEndTimeObserver()
    addTimeObserver()
  }
  
  private func addPlayerDidPlayToEndTimeObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(pushStudyReviewVC), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
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
  
  private func removeObservers() {
    removeTimeObserver()
    NotificationCenter.default.removeObserver(self)
  }
  
  
  private func setupQnAModel() {
    self.qnas.removeAll()
    StudyService.qnaAddListener(studyDocumentID: model.documentID) { (result) in
      self.qnas = result
      self.qnas.sort { $0.data.playTime < $1.data.playTime }
      self.tableViewBottomScroll()
    }
  }
  
  private func tableViewBottomScroll() {
    guard !qnas.isEmpty else { return }
    
    customView.tableViewBottomScroll(row: qnas.count - 1)
  }
  
  // MARK: Action
  
  
  private func setLotation(isFull: Bool) {
    let orientation: UIInterfaceOrientation = isFull ? .landscapeRight: .portrait
    let value = orientation.rawValue
    UIDevice.current.setValue(value, forKey: "orientation")
  }
  
  private func seekPlayer(to: Int64) {
    let seekTime = CMTime(value: to * Int64(NSEC_PER_SEC), timescale: Int32(NSEC_PER_SEC))
    guard let player = player else { return }
    print(seekTime)
    player.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
    if player.timeControlStatus.rawValue != 2 {
      player.play()
    }
  }
  
  @objc private func popRootViewController(sender: UIBarButtonItem) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc private func pushStudyReviewVC() {
    let reviewVC = StudyReviewVC(study: model, qnas: qnas)
    navigationController?.pushViewController(reviewVC, animated: true)
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
      studyDocumentID: model.documentID,
      playTime: playTime,
      title: title,
      userID: SignService.user.nickName,
      isDone: false
    )
    
    StudyService.qnaUpdate(model: qna)
  }
}

// MARK: UITableViewDataSource

extension InProcessStudyVC: UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    qnas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: indexPath) as! QuestionCell
    cell.configure(qna: qnas[indexPath.row].data)
    return cell
  }
  
  
}

// MARK: UITableViewDelegate
extension InProcessStudyVC: UITableViewDelegate {
  
  
}

