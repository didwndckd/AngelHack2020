//
//  StudyFrameView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyFrameView<TopView: UIView, BottomView: UIView>: View {
  
  private let _topView = TopView()
  private let _bottomView = BottomView()
  
  var topView: TopView { _topView }
  var bottomView: BottomView { _bottomView }
    
  override func attribute() {
    super.attribute()
  }
  
  override func setupUI() {
    super.setupUI()
    
    [_topView, _bottomView].forEach({
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    })
    
    let guide = safeAreaLayoutGuide
    
    _topView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    _topView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    _topView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    _topView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3).isActive = true
    
    _bottomView.topAnchor.constraint(equalTo: _topView.bottomAnchor).isActive = true
    _bottomView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    _bottomView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    _bottomView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
}
