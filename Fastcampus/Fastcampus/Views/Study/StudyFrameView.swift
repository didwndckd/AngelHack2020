//
//  StudyFrameView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyFrameView<TopView: UIView, BottomView: UIView>: View {
  
  private let _headerView = TopView()
  private let _bodyView = BottomView()
  
  var headerView: TopView { _headerView }
  var bodyView: BottomView { _bodyView }
    
  override func attribute() {
    super.attribute()
  }
  
  override func setupUI() {
    super.setupUI()
    
    [_headerView, _bodyView].forEach({
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    })
    
    let guide = safeAreaLayoutGuide
    
    _headerView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    _headerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    _headerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    _headerView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3).isActive = true
    
    _bodyView.topAnchor.constraint(equalTo: _headerView.bottomAnchor).isActive = true
    _bodyView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    _bodyView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    _bodyView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
}
