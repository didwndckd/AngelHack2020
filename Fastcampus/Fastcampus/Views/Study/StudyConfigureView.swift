//
//  StudyConfigureView.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol StudyConfigureViewDelegate: class {
  func didTap()
}

class StudyConfigureView: View {
  
  weak var delegate: StudyConfigureViewDelegate?
  
  private let titleLable = UILabel()
  
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
