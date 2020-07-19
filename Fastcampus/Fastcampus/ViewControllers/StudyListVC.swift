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
  
  private var studys = [Study]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "참여중인 스터디"
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    tableView.contentInset.top = 16
    tableView.separatorStyle = .none
    tableView.register(StudyListTableViewCell.self, forCellReuseIdentifier: StudyListTableViewCell.identifier)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getStudyList()
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
          self.studys.sort { $0.data.dateValue < $1.data.dateValue }
          self.tableView.reloadData()
        }
      }
    }
  }
  
}



// MARK: - UITableViewDataSource

extension StudyListVC {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    studys.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StudyListTableViewCell.identifier, for: indexPath) as! StudyListTableViewCell
    cell.configure(data: studys[indexPath.row].data)
    return cell
  }
}

// MARK: - UITableViewDelegate

extension StudyListVC {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let study = studys[indexPath.row]
    let studyVC = WaitingStudyVC(study: study)
    navigationController?.pushViewController(studyVC, animated: true)
  }
}
