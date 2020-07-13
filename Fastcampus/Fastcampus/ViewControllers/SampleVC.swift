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
}

extension SampleVC: SampleViewDelegate {
  func test() {
    
  }
}
