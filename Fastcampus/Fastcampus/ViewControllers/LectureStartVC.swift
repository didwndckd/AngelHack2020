//
//  LectureStartVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CodableFirebase
import AVFoundation

enum LectureTabType {
  case introduce
  case study
  case summary
}

class LectureStartVC: PlayerViewController {
  private var currentTab: LectureTabType = .introduce {
    didSet {
      if currentTab == .introduce {
        buttonUnderlineView.snp.remakeConstraints {
          $0.top.equalTo(buttonStackView.snp.bottom)
          $0.centerX.equalTo(introduceButton.snp.centerX)
          $0.width.equalTo(underlineWidth)
          $0.height.equalTo(5)
        }
      } else if currentTab == .study {
        buttonUnderlineView.snp.remakeConstraints {
          $0.top.equalTo(buttonStackView.snp.bottom)
          $0.centerX.equalTo(studyButton.snp.centerX)
          $0.width.equalTo(underlineWidth)
          $0.height.equalTo(5)
        }
      } else {
        buttonUnderlineView.snp.remakeConstraints {
          $0.top.equalTo(buttonStackView.snp.bottom)
          $0.centerX.equalTo(summaryButton.snp.centerX)
          $0.width.equalTo(underlineWidth)
          $0.height.equalTo(5)
        }
      }
    }
  }
  
  
  private let db = Firestore.firestore()
  private var underlineWidth: CGFloat = 0
  private let videoView = UIView()
  private lazy var buttonStackView = UIStackView(arrangedSubviews: [introduceButton, studyButton, summaryButton])
  private let introduceButton = UIButton()
  private let studyButton = UIButton()
  private let summaryButton = UIButton()
  private let buttonUnderlineView = UIView()
  private let separatorView = UIView()
  private let tabTableView = UITableView()
  private let makeStudyButton = UIButton()
  
  var study: [StudyModel] = [] {
    didSet {
      if study.count == 0 {
        tabTableView.setEmptyView(
          title: "스터디 없음",
          message: "신청된 스터디가 없어요 ㅠㅠ\n스터디를 만들어보세요."
        )
      } else {
        tabTableView.restore()
      }
      DispatchQueue.main.async {
        self.tabTableView.reloadData()
      }
    }
  }
  var summary: [Summary] = [] {
    didSet {
      if summary.count == 0 {
        tabTableView.setEmptyView(
          title: "요약 없음",
          message: "작성된 요약이 없어요 ㅠㅠ\n요약본을 올려보세요."
        )
      } else {
        tabTableView.restore()
      }
      DispatchQueue.main.async {
        self.tabTableView.reloadData()
      }
    }
  }
  private let lecture: Lecture
  private let chapter: ChapterModel
  private let unit: UnitModel
  private var users: [UserModel] = []
  
  init(lecture: Lecture, chapter: ChapterModel, unit: UnitModel) {
    self.lecture = lecture
    self.chapter = chapter
    self.unit = unit
    let subtitle = "\(chapter.title) - \(unit.title)"
    super.init(nibName: nil, bundle: nil)
    self.navigationItem.setTitle(chapter.title, subtitle: subtitle)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  private func getStudyList() {
    self.study = []
    db.collection("Study")
      .whereField("lectureID", isEqualTo: lecture.documentID)
      .whereField("chapterID", isEqualTo: chapter.index)
      .whereField("unitID", isEqualTo: unit.index)
      .getDocuments { [weak self] (querySnapshot, err) in
        guard let self = self else { return }
        if let err = err {
          print("[Log] Error :", err.localizedDescription)
        } else {
          if let documents = querySnapshot?.documents {
            for document in documents {
              var studyData = try! FirestoreDecoder().decode(StudyModel.self, from: document.data())
              studyData.documentID = document.documentID
              self.study.append(studyData)
            }
          }
        }
    }
  }
  
  private func getSummaryList() {
    db.collection("Summary")
      .document("\(lecture.id)")
      .collection("\(chapter.index)").getDocuments { [weak self] (querySnapshot, err) in
      guard let self = self else { return }
      if let err = err {
        print("[Log] Error :", err.localizedDescription)
      } else {
        if let documents = querySnapshot?.documents {
          for document in documents {
            var model = try! FirestoreDecoder().decode(Summary.self, from: document.data())
            model.documentID = document.documentID
            self.summary.append(model)
          }
          if self.summary.isEmpty {
            self.summary = []
          }
          
        }
      }
    }
  }
  
  private func updateSelectButtonStyle(lectureTabType: LectureTabType) {
    [introduceButton, studyButton, summaryButton].forEach {
      $0.setTitleColor(.black, for: .normal)
    }
    switch lectureTabType {
      case .introduce:
        introduceButton.setTitleColor(UIColor.myRed, for: .normal)
      case .study:
        studyButton.setTitleColor(UIColor.myRed, for: .normal)
      case .summary:
        summaryButton.setTitleColor(UIColor.myRed, for: .normal)
    }
  }
  
  private func updateUnderlineWidth(lectureTabType :LectureTabType) {
    if lectureTabType == .introduce {
      underlineWidth = (introduceButton.titleLabel!.text! as NSString).size(withAttributes: [NSAttributedString.Key.font : introduceButton.titleLabel!.font as Any]).width + 40
    } else if lectureTabType == .study {
      underlineWidth = (studyButton.titleLabel!.text! as NSString).size(withAttributes: [NSAttributedString.Key.font : studyButton.titleLabel!.font as Any]).width + 40
    } else {
      underlineWidth = (summaryButton.titleLabel!.text! as NSString).size(withAttributes: [NSAttributedString.Key.font : summaryButton.titleLabel!.font as Any]).width + 40
    }
  }
  
  private func attribute() {
    self.view.backgroundColor = .white
    
    playerView.backgroundColor = .black
    
    [introduceButton, studyButton, summaryButton].forEach {
      let title = $0 == introduceButton ? "강의 소개" : $0 == studyButton ? "스터디" : "요약"
      let color = $0 == introduceButton ? UIColor.myRed : UIColor.black
      $0.setTitle(title, for: .normal)
      $0.setTitleColor(color, for: .normal)
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    introduceButton.addTarget(self, action: #selector(touchUpIntroduceButton), for: .touchUpInside)
    studyButton.addTarget(self, action: #selector(touchUpStudyButton), for: .touchUpInside)
    summaryButton.addTarget(self, action: #selector(touchUpSummaryButton), for: .touchUpInside)
    
    buttonStackView.axis = .horizontal
    buttonStackView.alignment = .center
    buttonStackView.distribution = .fillEqually
    
    buttonUnderlineView.backgroundColor = UIColor.myRed
    buttonUnderlineView.layer.cornerRadius = 2
    updateUnderlineWidth(lectureTabType: .introduce)
    
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [
      UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1).cgColor,
      UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
    ]
    gradient.locations = [0.0, 1.0]
    gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 5)
    separatorView.layer.insertSublayer(gradient, at: 0)
    
    tabTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    tabTableView.dataSource = self
    tabTableView.delegate = self
    tabTableView.register(LectureIntroduceCell.self, forCellReuseIdentifier: LectureIntroduceCell.identifier)
    tabTableView.register(LectureSummaryCell.self, forCellReuseIdentifier: LectureSummaryCell.identifier)
    
    makeStudyButton.setTitle("스터디 만들기  >", for: .normal)
    makeStudyButton.setTitleColor(UIColor.myRed, for: .normal)
    makeStudyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    makeStudyButton.backgroundColor = .white
    makeStudyButton.layer.borderWidth = 2
    makeStudyButton.layer.borderColor = UIColor.myRed.cgColor
    makeStudyButton.layer.cornerRadius = 8
    makeStudyButton.addTarget(self, action: #selector(touchUpMakeButton), for: .touchUpInside)
    
    makeStudyButton.isHidden = true
  }
  
  private func setupUI() {
    let guide = self.view.safeAreaLayoutGuide
    let margins: CGFloat = 15
    [playerView, buttonStackView, buttonUnderlineView, separatorView, tabTableView, makeStudyButton]
      .forEach { self.view.addSubview($0) }
    
    playerView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.3)
    }
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(playerView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
    
    buttonUnderlineView.snp.makeConstraints {
      $0.top.equalTo(buttonStackView.snp.bottom)
      $0.centerX.equalTo(introduceButton.snp.centerX)
      $0.width.equalTo(underlineWidth)
      $0.height.equalTo(5)
    }
    
    separatorView.snp.makeConstraints {
      $0.top.equalTo(buttonUnderlineView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(3)
    }
    
    tabTableView.snp.makeConstraints {
      $0.top.equalTo(separatorView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom)
    }
    
    makeStudyButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom).offset(-margins)
      $0.width.equalToSuperview().multipliedBy(0.4)
      $0.height.equalTo(36)
    }
  }
  
  override func changeFullScreen() {
    super.changeFullScreen()
    view.bringSubviewToFront(playerView)
    let guide = view.safeAreaLayoutGuide
    view.backgroundColor = .black
    playerView.snp.remakeConstraints({
      $0.leading.top.trailing.bottom.equalTo(guide)
    })
    view.layoutIfNeeded()
  }
  
  override func changeMiniScreen() {
    super.changeMiniScreen()
    view.backgroundColor = .white
    playerView.snp.remakeConstraints({
      let guide = view.safeAreaLayoutGuide
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.3)
    })
    view.layoutIfNeeded()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LectureStartVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch currentTab {
      case .introduce:
        return 1
      case .study:
        return study.count
      case .summary:
        return summary.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if currentTab == .introduce {
      let cell = tableView.dequeueReusableCell(withIdentifier: LectureIntroduceCell.identifier, for: indexPath) as! LectureIntroduceCell
      cell.updateHeight(height: tableView.frame.height - self.view.safeAreaInsets.bottom)
      cell.setProperties(title: lecture.title, description: unit.description)
      return cell
    } else if currentTab == .study {
      let cell = LectureStudyCell()
      cell.delegate = self
      cell.selectionStyle = .none
      if let allUser = UserService.allUser {
        let user = allUser.filter { $0.uid == study[indexPath.row].userIDs[0] }.first!
        cell.setProperties(study: study[indexPath.row], user: user)
      }
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: LectureSummaryCell.identifier, for: indexPath) as! LectureSummaryCell
      cell.delegate = self
      cell.selectionStyle = .none
      if let allUser = UserService.allUser {
        let user = allUser.filter { $0.uid == summary[indexPath.row].userID }.first!
        cell.setProperties(summary: summary[indexPath.row], user: user)
      }
      
      return cell
    }
  }
}

extension LectureStartVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch currentTab {
      case .introduce:
        break
      case .study:
        break
      case .summary:
        let summaryVC = SummaryVC(lecture: lecture, chapter: chapter, unit: unit, summary: summary[indexPath.row])
        self.navigationController?.pushViewController(summaryVC, animated: true)
        break
    }
  }
}

private extension LectureStartVC {
  @objc private func touchUpIntroduceButton() {
    updateUnderlineWidth(lectureTabType: .introduce)
    currentTab = .introduce
    tabTableView.reloadData()
    updateSelectButtonStyle(lectureTabType: .introduce)
    makeStudyButton.isHidden = true
  }
  
  @objc private func touchUpStudyButton() {
    updateUnderlineWidth(lectureTabType: .study)
    currentTab = .study
    tabTableView.reloadData()
    makeStudyButton.setTitle("스터디 만들기  >", for: .normal)
    updateSelectButtonStyle(lectureTabType: .study)
    getStudyList()
    makeStudyButton.isHidden = false
  }
  
  @objc private func touchUpSummaryButton() {
    updateUnderlineWidth(lectureTabType: .summary)
    currentTab = .summary
    tabTableView.reloadData()
    makeStudyButton.setTitle("요약본 올리기  >", for: .normal)
    updateSelectButtonStyle(lectureTabType: .summary)
    getSummaryList()
    makeStudyButton.isHidden = false
  }
  
  @objc private func touchUpMakeButton() {
    switch currentTab {
      case .introduce:
        break
      case .study:
        let vcStudyConfigre = StudyConfigureVC(lecture: lecture, chapter: chapter, unit: unit)
        vcStudyConfigre.modalPresentationStyle = .overFullScreen
        present(vcStudyConfigre, animated: true)
        break
      case .summary:
        let summaryEditorVC = SummaryEditorVC(lecture: lecture, chapter: chapter, unit: unit)
        self.navigationController?.pushViewController(summaryEditorVC, animated: true)
        break
    }
  }
}

extension LectureStartVC: LectureStudyCellDelegate {
  func notice() {
    let alert = UIAlertController(
      title: "공석알림",
      message: "모집이 마감된 스터디입니다.\n공석 알림을 설정하시겠습니까?",
      preferredStyle: .alert
    )
    let cancelButton = UIAlertAction(title: "취소", style: .destructive, handler: nil)
    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
    alert.addAction(cancelButton)
    alert.addAction(okButton)
    self.present(alert, animated: true, completion: nil)
  }
  
  func joinStudy(studyID: String) {
    StudyService.getStudy(studyDocumentID: studyID) { [weak self] result in
      guard let self = self else { return }
      switch result {
        case .success(let studyData):
          let studyConfigureVC = StudyConfigureVC(lecture: self.lecture, chapter: self.chapter, unit: self.unit, study: studyData)
          studyConfigureVC.modalPresentationStyle = .overFullScreen
          studyConfigureVC.studyConfigureType = .join
          self.present(studyConfigureVC, animated: true, completion: nil)
        case .failure(let err):
          print("[Log] Error :", err.localizedDescription)
      }
    }
  }
}

extension LectureStartVC: LectureSummaryCellDelegate {
  func favoriteSummary(summaryID: Int, sender: UIButton) {
    //TODO:- 즐겨찾기 버튼을 눌렀을 때
    let image = sender.isSelected ? #imageLiteral(resourceName: "icon_favorite_deselected") : #imageLiteral(resourceName: "icon_favorite_selected")
    sender.setImage(image, for: .normal)
    sender.isSelected.toggle()
  }
}

extension LectureStartVC {
  
  
}
