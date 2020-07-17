//
//  CircleView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class CircleView: UIView {

  override func layoutSubviews() {
    super.layoutSubviews()
    let cornerRadius = (bounds.width > bounds.height ? bounds.height: bounds.width) / 2
    self.layer.cornerRadius = cornerRadius
  }
}
