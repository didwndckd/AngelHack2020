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
    })
    
    let guide = safeAreaLayoutGuide
    _headerView.snp.makeConstraints({
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(guide).multipliedBy(0.4)
    })
    
    _bodyView.snp.makeConstraints({
      $0.height.equalTo(guide).multipliedBy(0.6)
      $0.leading.trailing.bottom.equalTo(guide)
    })
    
  }
  
}
