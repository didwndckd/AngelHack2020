//
//  ExtensionUINavigationItem.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

extension UINavigationItem {
  func setTitle(_ title: String, subtitle: String) {
    let appearance = UINavigationBar.appearance()
    let textColor = appearance.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor ?? .black

    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    titleLabel.textColor = textColor

    let subtitleLabel = UILabel()
    subtitleLabel.text = subtitle
    subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    subtitleLabel.textColor = #colorLiteral(red: 0.6806092858, green: 0.6802064776, blue: 0.6997460127, alpha: 1)

    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.distribution = .equalCentering
    stackView.alignment = .leading
    stackView.axis = .vertical

    self.titleView = stackView
  }
}

