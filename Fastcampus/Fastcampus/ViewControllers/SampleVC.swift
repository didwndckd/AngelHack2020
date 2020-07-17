//
//  SampleVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SampleVC: ViewController<SampleView> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    customView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
}

extension SampleVC: SampleViewDelegate {
  func test() {
    
  }
}
