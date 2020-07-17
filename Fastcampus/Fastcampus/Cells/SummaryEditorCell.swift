//
//  SummaryEditorCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryEditorCell: UICollectionViewCell {
  private let summaryImageView = UIImageView()
  
  static let identifier = "SummaryEditorCell"
  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupUI()
  }
  
  private func attribute() {
    summaryImageView.backgroundColor = .lightGray
    summaryImageView.layer.cornerRadius = 4
    summaryImageView.clipsToBounds = true
  }
  
  private func setupUI() {
    let margins: CGFloat = 5
    contentView.addSubview(summaryImageView)
    summaryImageView.snp.makeConstraints {
      $0.top.leading.equalTo(contentView).offset(margins)
      $0.trailing.bottom.equalTo(contentView).offset(-margins)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
