//
//  DisignableTextField.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class DisignableTextField: UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
  }
  
  convenience init(placeHolder: String, rightImage: UIImage? = nil) {
    self.init()
    self.placeholder = placeHolder
    if let image = rightImage {
      makeRightImage(image: image)
    }
  }
  
  private func makeRightImage(image: UIImage) {
    let view = UIView(frame: CGRect(x: 10, y: self.frame.midY, width: 30, height: 20))
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    view.addSubview(imageView)
    self.rightView = view
    self.rightViewMode = .always
  }
  
  private func attribute() {
    self.borderStyle = .roundedRect
    self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
    self.leftViewMode = .always
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
