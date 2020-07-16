//
//  SideMenuVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
  private let menuList: [String] = ["완주율", "요약본", "스터디 참여 내역", "질문 내역"]
  private var firstOpen: Bool = true
  private let bgView = UIView()
  private let sideMenuTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if firstOpen {
      animations(willOpen: true)
      firstOpen = false
    }
  }
  
  private func animations(willOpen: Bool) {
    if willOpen {
      UIView.animate(withDuration: 0.3) {
        self.bgView.alpha = 0.6
        self.sideMenuTableView.center.x = -(self.view.frame.width / 4) * 3
      }
    } else {
      UIView.animate(withDuration: 0.3, animations: {
        self.bgView.alpha = 0
        self.sideMenuTableView.transform.tx = (self.view.frame.width / 4) * 3
      }) { _ in
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  
  private func attribute() {
    bgView.backgroundColor = .black
    bgView.alpha = 0
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(touchUpEmptyView))
    bgView.addGestureRecognizer(tap)
    
    sideMenuTableView.dataSource = self
    sideMenuTableView.delegate = self
    sideMenuTableView.separatorStyle = .none
  }
  
  private func setupUI() {
    [bgView, sideMenuTableView]
      .forEach { self.view.addSubview($0) }
    
    bgView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    sideMenuTableView.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
      $0.width.equalTo((UIScreen.main.bounds.width / 4) * 3)
    }
  }
}

extension SideMenuVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = SideMenuCell()
    cell.setProperties(at: indexPath.row, title: menuList[indexPath.row])
    return cell
  }
}

extension SideMenuVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let sideMenuHeaderView = SideMenuHeaderView()
    return sideMenuHeaderView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 160
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}

private extension SideMenuVC {
  @objc private func touchUpEmptyView() {
    animations(willOpen: false)
  }
}
