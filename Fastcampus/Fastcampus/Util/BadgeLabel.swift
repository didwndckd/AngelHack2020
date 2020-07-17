//
//  BadgeLabel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {
  var padding: UIEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
  
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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 4
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
