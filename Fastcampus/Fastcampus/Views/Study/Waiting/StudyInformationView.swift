//
//  StudyInformationView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyInformationView: View {

  private let titleLabel = UILabel()
  private let contentLabel = UILabel()
  private let isLongType: Bool
  
  init(isLongType: Bool) {
    self.isLongType = isLongType
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func attribute() {
    super.attribute()
    
    let titleFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    let contentFont: UIFont = isLongType ? .systemFont(ofSize: 16, weight: .semibold): .systemFont(ofSize: 14, weight: .regular)
    
    titleLabel.backgroundColor = .myRed
    titleLabel.font = titleFont
    titleLabel.textColor = .white
    
    contentLabel.font = contentFont
  }
  
  override func setupUI() {
    super.setupUI()
    
    [titleLabel, contentLabel].forEach({
      addSubview($0)
    })
    
    titleLabel.snp.makeConstraints({
      $0.leading.top.equalToSuperview()
    })
    
    contentLabel.snp.makeConstraints({
      let leading = isLongType ? snp.leading: titleLabel.snp.trailing
      let leftMargin: CGFloat = isLongType ? 0: 8
      
      let top = isLongType ? titleLabel.snp.bottom: snp.top
      let topMargin: CGFloat = isLongType ? 8: 0
      $0.leading.equalTo(leading).offset(leftMargin)
      $0.trailing.bottom.equalToSuperview()
      $0.top.equalTo(top).offset(topMargin)
    })
  }
  
}
