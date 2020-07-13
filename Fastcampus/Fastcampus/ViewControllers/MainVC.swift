//
//  ViewController.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MainVC: ViewController<MainView> {

  override func viewDidLoad() {
    super.viewDidLoad()
    customView.delegate = self
  }
}

extension MainVC: MainViewDelegate {
  func test() {
    
  }
}
