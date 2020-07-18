//
//  ChapterVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CodableFirebase

class ChapterVC: UIViewController {
  private let tableView = UITableView(frame: .zero, style: .grouped)
  private var lecture: Lecture
  private var chapters = [ChapterModel]()
  private var isFoldCache = [Int: Bool]()
  
  init(lecture: Lecture) {
    self.lecture = lecture
    super.init(nibName: nil, bundle: nil)
    self.title = lecture.title
    
    let db = Firestore.firestore().collection("Lecture").document(lecture.documentID).collection("Chapter")
    db.getDocuments { (snapshot, _) in
      guard let documents = snapshot?.documents else { return }
      for document in documents {
        let data = document.data()
        guard
          let index = data["index"] as? Int,
          let title = data["title"] as? String
          else { return }
        
        let inDB = Firestore.firestore()
          .collection("Lecture").document(lecture.documentID)
          .collection("Chapter").document(document.documentID)
          .collection("Units")
        
        inDB.order(by: "index", descending: false).getDocuments { (snapshot, _) in
          guard let inDocuments = snapshot?.documents else { return }
          var tempUnits = [UnitModel]()
          for inDocument in inDocuments {
            let tempUnit = try! FirestoreDecoder().decode(UnitModel.self, from: inDocument.data())
            tempUnits.append(tempUnit)
          }
          
          let tempChapter = ChapterModel(title: title, index: index, Units: tempUnits)
          self.chapters.append(tempChapter)
          
          // 마지막 데이터 완료 시 테이블뷰 리로드
          if self.chapters.count == documents.count {
            self.chapters.sort { $0.index < $1.index }
            self.tableView.reloadData()
          }
        }
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  private func attribute() {
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    view.backgroundColor = .white
    
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    let guide = view.safeAreaLayoutGuide
    let margins: CGFloat = 15
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: guide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margins),
      tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -margins),
      tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    ])
  }
}



// MARK: - UITableViewDataSource

extension ChapterVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return chapters.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let isFold = isFoldCache[section] else { return 0 }
    return isFold ? 0 : chapters[section].Units.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let unit = chapters[indexPath.section].Units[indexPath.row]
    let unitIndex = String(format: "%02d", unit.index)
    let text = "  " + unitIndex + ". " + unit.title
    cell.textLabel?.text = text
    cell.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
}



// MARK: - UITableViewDelegate

extension ChapterVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let chapterHeaderView = ChapterHeaderView()
    chapterHeaderView.tag = section
    let chapter = chapters[section]
    let chapterIndex = String(format: "%02d", chapter.index)
    let text = chapterIndex + ". " + chapter.title
    chapterHeaderView.setTitle(text: text)
    chapterHeaderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sectionDidTap(_:))))
    chapterHeaderView.isUserInteractionEnabled = true
    
    return chapterHeaderView
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let chapter = chapters[indexPath.section]
    let unit = chapter.Units[indexPath.row]
    let lectureStartVC = LectureStartVC(lecture: lecture, chapter: chapter, unit: unit)
    self.navigationController?.pushViewController(lectureStartVC, animated: true)
  }
  
  @objc private func sectionDidTap(_ sender: UITapGestureRecognizer) {
    var indexPath = [IndexPath]()
    
    for row in chapters[sender.view!.tag].Units.indices {
      let tempIndexPath = IndexPath(row: row, section: sender.view!.tag)
      indexPath.append(tempIndexPath)
    }
    
    let isFold = isFoldCache[sender.view!.tag] ?? true
    isFoldCache[sender.view!.tag] = !isFold
    
    isFold ?
      tableView.insertRows(at: indexPath, with: .fade):
      tableView.deleteRows(at: indexPath, with: .fade)
    
    if let headerView = sender.view as? ChapterHeaderView {
      headerView.toggleBottomSeparatorView(isHidden: isFoldCache[sender.view!.tag] ?? true)
    }
  }
  
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    58
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    0
  }
  
}

class ChapterHeaderView: UIView {
  private let titleLabel = UILabel()
  private let rightImageView = UIImageView()
  private let bottomSeparatorView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupUI()
  }
  
  func setTitle(text: String) {
    titleLabel.text = text
  }
  
  func toggleBottomSeparatorView(isHidden: Bool) {
    bottomSeparatorView.isHidden = isHidden
  }
  
  private func attribute() {
    titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    
    bottomSeparatorView.backgroundColor = .lightGray
    bottomSeparatorView.isHidden = true
  }
  
  private func setupUI() {
    let margins: CGFloat = 15
    [titleLabel, rightImageView, bottomSeparatorView]
      .forEach { self.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(self).offset(margins / 3)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(rightImageView.snp.leading).offset(-margins)
      $0.bottom.equalTo(self).offset(-margins / 3)
    }
    
    rightImageView.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.trailing.equalTo(self).offset(-margins)
      $0.width.height.equalTo(30)
    }
    
    bottomSeparatorView.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
      $0.bottom.equalTo(self)
      $0.height.equalTo(1)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
