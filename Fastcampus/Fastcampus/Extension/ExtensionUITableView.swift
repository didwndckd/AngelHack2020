//
//  ExtensionUITableView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

extension UITableView {
  func setEmptyView(title: String, message: String) {
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
    
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    titleLabel.text = title
    titleLabel.textColor = UIColor.black
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    
    messageLabel.text = message
    messageLabel.textColor = UIColor.lightGray
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
    messageLabel.numberOfLines = 0
    
    self.backgroundView = emptyView
    self.separatorStyle = .none
    
    [titleLabel, messageLabel]
      .forEach { emptyView.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.centerX.equalTo(emptyView)
      $0.bottom.equalTo(messageLabel.snp.top).offset(-20)
    }
    
    messageLabel.snp.makeConstraints {
      $0.center.equalTo(emptyView)
    }
  }
  
  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}

