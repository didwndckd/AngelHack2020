//
//  StudyInformationView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {
  private let padding: UIEdgeInsets
  
  init(_ insets: UIEdgeInsets) {
    self.padding = insets
      super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func drawText(in rect: CGRect) {
    let paddingRect = rect.inset(by: padding)
    super.drawText(in: paddingRect)
  }
  
  override var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += padding.top + padding.bottom
    contentSize.width += padding.left + padding.right
    return contentSize
  }

}

class StudyInformationView: View {

  private let titleLabel = InsetLabel(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
  private let contentLabel = UILabel()
  private let isLongType: Bool
  
  init(isLongType: Bool, title: String) {
    self.isLongType = isLongType
    titleLabel.text = title
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func attribute() {
    super.attribute()
    
    let titleFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    let contentFont: UIFont = !isLongType ? .systemFont(ofSize: 16, weight: .semibold): .systemFont(ofSize: 14, weight: .regular)
    
    titleLabel.backgroundColor = .myRed
    titleLabel.font = titleFont
    titleLabel.textColor = .white
    
    contentLabel.numberOfLines = isLongType ? 0: 1
    contentLabel.font = contentFont
    
    
  }
  
  override func setupUI() {
    super.setupUI()
    
    [titleLabel, contentLabel].forEach({
      addSubview($0)
    })
    
    
    let margin: CGFloat = 8
    
    
    if isLongType {
      titleLabel.snp.makeConstraints({
        $0.top.leading.equalToSuperview()
      })
      contentLabel.snp.makeConstraints({
        $0.leading.trailing.equalToSuperview()
        $0.top.equalTo(titleLabel.snp.bottom).offset(margin)
        $0.bottom.equalToSuperview()
      })
    } else {
      titleLabel.snp.makeConstraints({
        $0.top.leading.bottom.equalToSuperview()
      })
      contentLabel.snp.makeConstraints({
        $0.leading.equalTo(titleLabel.snp.trailing).offset(margin)
        $0.top.bottom.equalToSuperview()
      })
    }
  }
  
  func configure(description: String?) {
    contentLabel.text = description
  }
  
}
