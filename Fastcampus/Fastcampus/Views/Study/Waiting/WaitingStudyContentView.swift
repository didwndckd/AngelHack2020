//
//  WaitingStudyDescriptionView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WaitingStudyContentView: UIScrollView {
  
  private let ruleTitleLabel = UILabel()
  private let ruleContentLabel = UILabel()
  private let unitTitleLabel = UILabel()
  private let unitContentLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attribute() {
    [ruleTitleLabel, ruleContentLabel, unitTitleLabel, unitContentLabel].forEach({
      $0.numberOfLines = 0
    })
    let titleFont = UIFont.systemFont(ofSize: 30, weight: .bold)
//    let contentFont
    ruleTitleLabel.font = titleFont
    unitTitleLabel.font = titleFont
    
    ruleTitleLabel.text = "스터디 규칙"
  }
  
  private func setupUI() {
    let views = [ruleTitleLabel, ruleContentLabel, unitTitleLabel, unitContentLabel]
    
    views.enumerated().forEach() { (index, view) in
      addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
      
      let margin: CGFloat = 8
      
      let top = index == 0 ? topAnchor: views[index - 1].bottomAnchor
      
      view.topAnchor.constraint(equalTo: top, constant: margin).isActive = true
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
      view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
      view.widthAnchor.constraint(equalTo: widthAnchor, constant: -(margin * 2)).isActive = true
      
      if index == views.count - 1 {
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
      }
    }
    
  }
  
  func configure(rule: String, unitTitle: String, unitContent: String) {
    ruleContentLabel.text = rule
    unitTitleLabel.text = unitTitle
    unitContentLabel.text = unitContent
  }
  
  
}
