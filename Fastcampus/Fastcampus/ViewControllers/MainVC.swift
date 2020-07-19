//
//  ViewController.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseFirestore
import CodableFirebase

enum MainCategory: Int {
  case all = 0
  case expected = 1
  case studying = 2
  case finish = 3
}

class MainVC: UIViewController {
  private let titleList: [String] = ["전체목록", "수강예정", "수강중", "수강완료"]
  private var currentCategory: MainCategory = .all {
    didSet {
      switch currentCategory {
        case .all:
          break
        case .expected:
          break
        case .studying:
          break
        case .finish:
          break
      }
      print("[Log] currentCategory :", currentCategory)
    }
  }
  private var lecture: [Lecture] = [] {
    didSet { self.lectureTableView.reloadData() }
  }
  private let db = Firestore.firestore()
  private let mainScrollView = UIScrollView()
  private let headerContainerView = UIView()
  private let iconImageView = UIImageView()
  private let headerTitleLabel = UILabel()
  private let titleStackView = UIStackView()
  private let lectureTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatorLectureData()
    makeTitleStackView()
    attribute()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  private func makeTitleStackView() {
    for idx in 0..<4 {
      let button = UIButton()
      button.tag = idx
      button.setTitle(titleList[idx], for: .normal)
      let titleColor = idx == 0 ? UIColor.white : #colorLiteral(red: 0.5986129642, green: 0.5988268256, blue: 0.6187592149, alpha: 1)
      button.setTitleColor(titleColor, for: .normal)
      let backgroundColor = idx == 0 ? UIColor.myRed : #colorLiteral(red: 0.9109585881, green: 0.9112133384, blue: 0.929444015, alpha: 1)
      button.backgroundColor = backgroundColor
      button.layer.cornerRadius = 12
      button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
      button.addTarget(self, action: #selector(menuDidTap(_:)), for: .touchUpInside)
      titleStackView.addArrangedSubview(button)
    }
  }
  
  private func populatorLectureData() {
    //TODO:- Network Service 만들 것
    db.collection("Lecture").getDocuments { [weak self] (querySnapshot, err) in
      guard let self = self else { return }
      if let err = err {
        print("[Log] Error :", err.localizedDescription)
      } else {
        //TODO:- append가 아니고 [Lecture]로 Decoding
        if let documents = querySnapshot?.documents {
          for document in documents {
            let model = try! FirestoreDecoder().decode(Lecture.self, from: document.data())
            self.lecture.append(model)
          }
        }
      }
    }
  }
  
  private func attribute() {
    //Temp
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "사이드메뉴", style: .done, target: self, action: #selector(sideMenuDidTap))
    
    self.view.backgroundColor = .white
    
    mainScrollView.delegate = self
    
    iconImageView.image = #imageLiteral(resourceName: "icon_logo_color")
    iconImageView.contentMode = .scaleAspectFit
    
    headerTitleLabel.text = "김패캠 님의 강의"
    headerTitleLabel.textColor = .black
    headerTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    let attributedStr = NSMutableAttributedString(string: headerTitleLabel.text!)
    attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 17), range: (headerTitleLabel.text! as NSString as NSString).range(of: "님의 강의"))
    headerTitleLabel.attributedText = attributedStr
    
    titleStackView.axis = .horizontal
    titleStackView.alignment = .fill
    titleStackView.distribution = .fillProportionally
    titleStackView.spacing = 12
    
    lectureTableView.bounces = false
    lectureTableView.separatorStyle = .none
    lectureTableView.showsVerticalScrollIndicator = false
    lectureTableView.dataSource = self
    lectureTableView.delegate = self
    lectureTableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
  }
  
  private func setupUI() {
    let guide = self.view.safeAreaLayoutGuide
    let margins: CGFloat = 15
    self.view.addSubview(mainScrollView)
    
    [headerContainerView, titleStackView, lectureTableView]
      .forEach { mainScrollView.addSubview($0) }
    
    [iconImageView, headerTitleLabel]
      .forEach { headerContainerView.addSubview($0) }
    
    mainScrollView.snp.makeConstraints {
      $0.top.bottom.equalTo(guide)
      $0.leading.trailing.equalToSuperview()
    }
    
    headerContainerView.snp.makeConstraints {
      $0.top.leading.equalTo(mainScrollView).offset(margins)
      $0.trailing.equalToSuperview().offset(-margins)
      $0.height.equalTo(44)
      $0.width.equalTo(UIScreen.main.bounds.width - (margins * 2))
    }
    
    iconImageView.snp.makeConstraints {
      $0.centerY.equalTo(headerContainerView)
      $0.leading.equalTo(headerContainerView)
      $0.width.height.equalTo(35)
    }

    headerTitleLabel.snp.makeConstraints {
      $0.centerY.equalTo(headerContainerView)
      $0.leading.equalTo(iconImageView.snp.trailing)
      $0.trailing.equalTo(headerContainerView).offset(-margins)
    }

    titleStackView.snp.makeConstraints {
      $0.top.equalTo(headerContainerView.snp.bottom).offset(margins)
      $0.leading.equalToSuperview().offset(margins)
      $0.trailing.equalToSuperview().offset(-margins)
      $0.height.equalTo(33)
    }

    lectureTableView.snp.makeConstraints {
      $0.top.equalTo(titleStackView.snp.bottom).offset(margins / 2)
      $0.leading.equalToSuperview().offset(margins)
      $0.trailing.equalToSuperview().offset(-margins)
      $0.bottom.equalTo(guide.snp.bottom).offset(-margins)
    }
  }
}

extension MainVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lecture.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
    cell.selectionStyle = .none
    cell.setProperties(lecture: lecture[indexPath.row])
    cell.setGradientBackground()
    return cell
  }
}

extension MainVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.height / 2.5
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let chapterVC = ChapterVC(lecture: lecture[indexPath.row])
    self.navigationController?.pushViewController(chapterVC, animated: true)
  
    
//    if lecture[indexPath.row].id == 2 {
//      let chapterVC = ChapterVC(lecture: lecture[indexPath.row])
//      self.navigationController?.pushViewController(chapterVC, animated: true)
//    }
//
//
//
//    if indexPath.row == 2 { // 스터디 화면 테스트용 입니다.
//      let vc = WaitingStudyVC(studyModel: StudyModel(
//        title: "1회차 같이 완주해요!",
//        lectureID: "lectureID",
//        lectureTitle: "UX/UI 디자인 올인원 패키지 Online.",
//        chapterID: 1,
//        unitID: 1,
//        unitTitle: "01. 디자인 개론-01. 강사, 강의소개",
//        unitDescription: """
//        UX/UI 디자인 올인원 패키지의 첫번째 강의입니다.\n
//        앞으로 공부할 UX/ UI의 기초개념을 알아보고 강사님을 소개합니다.
//        """,
//        date: Timestamp(date: Date(timeInterval: 3600, since: Date())),
//        fixed: 10,
//        rule: "욕설 비방 하지마세요\n질문 많이 올려주세요\n요약 무조건 올리기 입니다.",
//        userIDs: ["중창", "업스", "현철", "현영", "예은"],
//        qnaIDs: [],
//        inProcess: .wait))
//
//      navigationController?.pushViewController(vc, animated: true)
//    }

  }
}

//extension MainVC: UIScrollViewDelegate {
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    if scrollView.contentOffset.y < 59 {
//      mainScrollView.contentOffset.y = scrollView.contentOffset.y
//      self.title = nil
//    } else {
//      self.title = "김패캠 님의 강의"
//    }
//  }
//}


// MARK: - 임시 스터디 생성 / 작성자: UPs

private extension MainVC {
  @objc private func sideMenuDidTap() {
//    let summaryVC = SummaryVC()
//    summaryVC.modalPresentationStyle = .fullScreen
//    self.present(summaryVC, animated: true, completion: nil)
//    let sideMenuVC = SideMenuVC()
//    sideMenuVC.modalPresentationStyle = .overFullScreen
//    self.present(sideMenuVC, animated: false)
  }
  
  @objc private func menuDidTap(_ sender: UIButton) {
    for (idx, view) in titleStackView.arrangedSubviews.enumerated() {
      let menuButton = view as! UIButton
      let titleColor = sender.tag == idx ? UIColor.white : #colorLiteral(red: 0.5986129642, green: 0.5988268256, blue: 0.6187592149, alpha: 1)
      menuButton.setTitleColor(titleColor, for: .normal)
      let backgroundColor = sender.tag == idx ? UIColor.myRed : #colorLiteral(red: 0.9109585881, green: 0.9112133384, blue: 0.929444015, alpha: 1)
      menuButton.backgroundColor = backgroundColor
    }
    currentCategory = MainCategory(rawValue: sender.tag)!
  }
}
