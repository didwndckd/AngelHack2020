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

class MainVC: UITableViewController {
  private var lecture: [Lecture] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  private let db = Firestore.firestore()
  override func viewDidLoad() {
    super.viewDidLoad()
    populatorLectureData()
    attribute()
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
    self.title = "온라인 강좌"
    
    self.tableView.separatorStyle = .none
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.largeTitleDisplayMode = .always
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lecture.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
    cell.setProperties(lecture: lecture[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.height / 3
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath.row == 2 { // 스터디 화면 테스트용 입니다.
      let vc = WaitingStudyVC(
        study: Study(
        id: 1,
        title: "Let's Swift 스터디",
        date: Date(timeIntervalSinceNow: 3600),
        rule: "비방, 욕설 하지마세요 ~ ",
        userIDs: [],
        qnaIDs: [],
        inProcess: .wait,
        unitTitle: lecture[indexPath.row].title,
        unitContent: "강의\nSwift 기초 강의\n잘해봐요~")
      )
      
      navigationController?.pushViewController(vc, animated: true)
      
    }
    
  }
}
