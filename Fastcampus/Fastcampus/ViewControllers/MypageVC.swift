//
//  SideMenuVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MypageVC: UIViewController {
  private let menuTitleList = ["요약본", "스터디 참여", "질문 내역"]
  private let menuList = [["내가 작성한 요약본", "저장한 요약본"], ["참여 예정 스터디", "스터디 참여 내역"], ["내가 한 질문", "저장한 질문"]]
  private let mypageHeaderView = MypageHeaderView()
  private let mypageTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  private func attribute() {
    self.view.backgroundColor = .white
    mypageTableView.dataSource = self
    mypageTableView.delegate = self
    mypageTableView.separatorStyle = .none
    mypageTableView.bounces = false
  }
  
  private func setupUI() {
    let guide = self.view.safeAreaLayoutGuide
    [mypageHeaderView, mypageTableView]
      .forEach { self.view.addSubview($0) }
    
    mypageHeaderView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(UIScreen.main.bounds.height / 4)
    }
    
    mypageTableView.snp.makeConstraints {
      $0.top.equalTo(mypageHeaderView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide)
    }
  }
}

extension MypageVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = MypageTitleCell()
      cell.setTitle(text: menuTitleList[indexPath.section])
      cell.isUserInteractionEnabled = false
      return cell
    } else {
      let cell = MypageCell()
      cell.setProperties(title: menuList[indexPath.section][indexPath.row - 1])
      return cell
    }
  }
}

extension MypageVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 20
  }
}