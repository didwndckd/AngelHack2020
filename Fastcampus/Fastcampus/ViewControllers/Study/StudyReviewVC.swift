//
//  StudyReViewVC.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyReviewVC: ViewController<StudyReviewView> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
  }
  
  private func setupNavigation() {
    title = "질문 채팅"
    setBackButton(selector: #selector(popRootViewController(_:)))
  }
  
  @objc private func popRootViewController(_ sender: UIBarButtonItem) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  
}
