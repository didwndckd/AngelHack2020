//
//  SummaryVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryVC: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  private func attribute() {
    self.view.backgroundColor = .white

    self.tableView = UITableView(frame: .zero, style: .grouped)
    self.tableView.separatorStyle = .none
    self.tableView.backgroundColor = #colorLiteral(red: 0.9452976584, green: 0.9455571771, blue: 0.9636406302, alpha: 1)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(CommentInputCell.self, forCellReuseIdentifier: CommentInputCell.identifier)
    self.tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: CommentInputCell.identifier, for: indexPath) as!
      CommentInputCell
      cell.delegate = self
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.identifier, for: indexPath) as! SummaryCell
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let summaryHeaderView = SummaryHeaderView()
    return summaryHeaderView
  }
}

extension SummaryVC: CommentInputCellDelegate {
  func addcomment(text: String) {
    //TODO:- 댓글 추가
  }
}
