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
  
  private var studys = [StudyModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset.top = 40
    tableView.separatorStyle = .none
    tableView.register(StudyListTableViewCell.self, forCellReuseIdentifier: StudyListTableViewCell.identifier)
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getStudyList()
  }
  
  
  private func getStudyList() {
    SignService.user.studys.forEach { studyID in
      self.studys.forEach { study in
        guard study.title == studyID else { return }
        StudyService.getStudyList(studyDocumentID: studyID) { (result) in
          switch result {
          case .failure(let error):
            self.alertNormal(title: error.localizedDescription)
            
          case .success(let data):
            self.studys.append(data)
            self.tableView.reloadData()
          }
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
    cell.configure(data: studys[indexPath.row])
    return cell
  }
}



// MARK: - UITableViewDelegate

extension StudyListVC {
  
}
