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
  
  private var chapters = [ChapterModel]()
  private var isFoldCache = [Int: Bool]()
  
  init(lectureID: String) {
    super.init(nibName: nil, bundle: nil)
    let db = Firestore.firestore().collection("Lecture").document(lectureID).collection("Chapter")
    
    db.getDocuments { (snapshot, _) in
      guard let documents = snapshot?.documents else { return }
      for document in documents {
        let data = document.data()
        guard
          let index = data["index"] as? Int,
          let title = data["title"] as? String
          else { return }
        
        let inDB = Firestore.firestore().collection("Lecture").document(lectureID).collection("Chapter").document(document.documentID).collection("Units")
        
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
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: guide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    ])
  }
}



// MARK: - UITableViewDataSource

extension ChapterVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    chapters.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let isFold = isFoldCache[section] else { return 0 }
    return isFold ? 0 : chapters[section].Units.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let unit = chapters[indexPath.section].Units[indexPath.row]
    let unitIndex = String(format: "%02d", unit.index)
    let text = unitIndex + ". " + unit.title
    cell.textLabel?.text = text
    cell.accessoryType = .disclosureIndicator
    
    return cell
  }
}



// MARK: - UITableViewDelegate

extension ChapterVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let button = UIButton()
    button.backgroundColor = .white
    button.tag = section
    
    let chapter = chapters[section]
    let chapterIndex = String(format: "%02d", chapter.index)
    let text = chapterIndex + ". " + chapter.title
    button.setTitle(text, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(sectionDidTap), for: .touchUpInside)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentHorizontalAlignment = .left
    
    return button
  }
  
  @objc private func sectionDidTap(_ sender: UIButton) {
    var indexPath = [IndexPath]()
    
    for row in chapters[sender.tag].Units.indices {
      let tempIndexPath = IndexPath(row: row, section: sender.tag)
      indexPath.append(tempIndexPath)
    }
    
    let isFold = isFoldCache[sender.tag] ?? true
    isFoldCache[sender.tag] = !isFold
    
    isFold ?
      tableView.insertRows(at: indexPath, with: .fade):
      tableView.deleteRows(at: indexPath, with: .fade)
      
  }
  
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    48
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    0
  }
  
}
