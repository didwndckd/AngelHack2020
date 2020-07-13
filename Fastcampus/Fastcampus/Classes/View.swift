//
//  View.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class View: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    attribute()
    setupUI()
  }
  
  func attribute() {
    backgroundColor = .white
  }
  
  func setupUI() {}
}
