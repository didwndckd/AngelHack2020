//
//  MainView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol MainViewDelegate: class {
  func test()
}

class MainView: View {
  weak var delegate: MainViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func attribute() {
    super.attribute()
  }
  
  override func setupUI() {
    super.setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension MainView {
  @objc private func testFunc() {
    delegate?.test()
  }
}
