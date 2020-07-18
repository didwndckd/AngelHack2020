//
//  StudyListVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

class StudyListVC: UITableViewController {
  
  let models = [
    StudyModel(title: "1회차 같이 완주해주세요!", lectureTitle: "꼼꼼한 재은씨", unitTitle: "애플의 새로운 언어, 스위프트", unitDescription: "애플에서 만든 새로운 언어 스위프트는 정말 깔끔하고 좋습니다. 개발에 아주 완벽한 언어입니다", date: Timestamp(), fixed: 8, rule: "친목 도모 x\n스터디 시간 지키기\n질문 최소 2개 이상 올리기", userIDs: ["유저ㅑㅇ"], qnaIDs: [], inProcess: .wait),
    StudyModel(title: "1회차 같이 완주해주세요!", lectureTitle: "꼼꼼한 재은씨", unitTitle: "애플의 새로운 언어, 스위프트", unitDescription: "애플에서 만든 새로운 언어 스위프트는 정말 깔끔하고 좋습니다. 개발에 아주 완벽한 언어입니다", date: Timestamp(), fixed: 8, rule: "친목 도모 x\n스터디 시간 지키기\n질문 최소 2개 이상 올리기", userIDs: ["유저ㅑㅇ"], qnaIDs: [], inProcess: .wait),
    StudyModel(title: "1회차 같이 완주해주세요!", lectureTitle: "꼼꼼한 재은씨", unitTitle: "애플의 새로운 언어, 스위프트", unitDescription: "애플에서 만든 새로운 언어 스위프트는 정말 깔끔하고 좋습니다. 개발에 아주 완벽한 언어입니다", date: Timestamp(), fixed: 8, rule: "친목 도모 x\n스터디 시간 지키기\n질문 최소 2개 이상 올리기", userIDs: ["유저ㅑㅇ"], qnaIDs: [], inProcess: .wait),
    StudyModel(title: "1회차 같이 완주해주세요!", lectureTitle: "꼼꼼한 재은씨", unitTitle: "애플의 새로운 언어, 스위프트", unitDescription: "애플에서 만든 새로운 언어 스위프트는 정말 깔끔하고 좋습니다. 개발에 아주 완벽한 언어입니다", date: Timestamp(), fixed: 8, rule: "친목 도모 x\n스터디 시간 지키기\n질문 최소 2개 이상 올리기", userIDs: ["유저ㅑㅇ"], qnaIDs: [], inProcess: .wait)
  ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset.top = 40
    tableView.separatorStyle = .none
    tableView.register(StudyListTableViewCell.self, forCellReuseIdentifier: StudyListTableViewCell.identifier)
  }
  
}



// MARK: - UITableViewDataSource

extension StudyListVC {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    models.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StudyListTableViewCell.identifier, for: indexPath) as! StudyListTableViewCell
    cell.configure(data: models[indexPath.row])
    return cell
  }
}



// MARK: - UITableViewDelegate

extension StudyListVC {
  
}
