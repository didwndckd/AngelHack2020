//
//  StudyListVC.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

class StudyListVC: UIViewController {
  private var studys = [Study]() {
    didSet {
      if studys.count == 0 {
        self.tableView.setEmptyView(
          title: "참여중인 스터디 없음!",
          message: """
          현재 참여중인 스터디가 없습니다.
          듣고 있는 강의의 스터디에 참가해보세요.
          """
        )
      } else {
        self.tableView.restore()
      }
      self.tableView.reloadData()
    }
  }
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "참여중인 스터디"
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    tableView.contentInset.top = 16
    tableView.separatorStyle = .none
    tableView.register(StudyListTableViewCell.self, forCellReuseIdentifier: StudyListTableViewCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getStudyList()
    self.tabBarController?.tabBar.items?[0].badgeValue = nil
  }
  
  private func getStudyList() {
    studys.removeAll()
    SignService.user.studys.forEach { studyID in
      StudyService.getStudy(studyDocumentID: studyID) { (result) in
        switch result {
        case .failure(let error):
          self.alertNormal(title: error.localizedDescription)
          
        case .success(let data):
          let temp = Study(documentID: studyID, data: data)
          self.studys.append(temp)
          self.studys.sort { $0.data.dateValue > $1.data.dateValue }
          self.tableView.reloadData()
        }
      }
    }
  }
  
}



// MARK: - UITableViewDataSource

extension StudyListVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    studys.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StudyListTableViewCell.identifier, for: indexPath) as! StudyListTableViewCell
    cell.configure(data: studys[indexPath.row].data)
    return cell
  }
}

// MARK: - UITableViewDelegate

extension StudyListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let study = studys[indexPath.row]
    let studyVC = WaitingStudyVC(study: study)
    studyVC.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(studyVC, animated: true)
  }
}
