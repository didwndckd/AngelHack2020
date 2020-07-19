//
//  PaddingLabel.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
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
}

