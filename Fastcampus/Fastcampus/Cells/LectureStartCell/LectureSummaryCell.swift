//
//  LectureSummaryCell.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol LectureSummaryCellDelegate: class {
  func favoriteSummary(summaryID: Int, sender: UIButton)
}

class LectureSummaryCell: UITableViewCell {
  static let identifier = "LectureSummaryCell"
  weak var delegate: LectureSummaryCellDelegate?
  private let titleLabel = UILabel()
  private let pageLabel = UILabel()
  private let nameLabel = UILabel()
  private let levelButton = UIButton()
  private let recommendCountLabel = UILabel()
  private let commentsCountLabel = UILabel()
  private let favoriteButton = UIButton()
  private let enterImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    attribute()
    setupUI()
  }
  
  func setProperties(summary: Summary) {
    titleLabel.text = summary.title
    
    UserService.getData(uid: summary.userID) { [weak self] result in
      guard let self = self else { return }
      switch result {
        case .success(let user):
          self.nameLabel.text = "작성자 \(user.nickName)"
          self.nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
          let attributedStr = NSMutableAttributedString(string: self.nameLabel.text!)
          attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: (self.nameLabel.text! as NSString as NSString).range(of: "작성자"))
          self.nameLabel.attributedText = attributedStr
        case .failure(let err):
          print("[Log] Error :", err.localizedDescription)
      }
    }
  }
  
  private func attribute() {
    titleLabel.textColor = .black
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    pageLabel.text = "3페이지"
    pageLabel.textColor = #colorLiteral(red: 0.676876843, green: 0.6769082546, blue: 0.6965678334, alpha: 1)
    pageLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    nameLabel.text = "작성자"
    nameLabel.textColor = .black
    
    levelButton.setTitle("Lv.9", for: .normal)
    levelButton.setTitleColor(.black, for: .normal)
    levelButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    levelButton.contentEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
    levelButton.layer.borderColor = UIColor.black.cgColor
    levelButton.layer.borderWidth = 1
    
    recommendCountLabel.text = "추천수 : 0개"
    recommendCountLabel.textColor = #colorLiteral(red: 0.6805432439, green: 0.6805752516, blue: 0.7002126575, alpha: 1)
    recommendCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    commentsCountLabel.text = "댓글수 : 0개"
    commentsCountLabel.textColor = #colorLiteral(red: 0.6805432439, green: 0.6805752516, blue: 0.7002126575, alpha: 1)
    commentsCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    favoriteButton.setImage(#imageLiteral(resourceName: "icon_favorite_deselected"), for: .normal)
    favoriteButton.contentMode = .scaleAspectFit
    favoriteButton.addTarget(self, action: #selector(touchUpFavoriteButton(_:)), for: .touchUpInside)
    
    enterImageView.image = #imageLiteral(resourceName: "icon_enter_black")
    enterImageView.contentMode = .scaleAspectFit
  }

  private func setupUI() {
    let margins: CGFloat = 15
    [titleLabel, pageLabel, nameLabel, levelButton, recommendCountLabel, commentsCountLabel, favoriteButton, enterImageView]
      .forEach { contentView.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(contentView).offset(margins)
    }
    
    pageLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.leading.equalTo(titleLabel.snp.trailing).offset(margins)
      $0.trailing.equalTo(favoriteButton.snp.leading)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(contentView).offset(margins)
    }
    
    levelButton.snp.makeConstraints {
      $0.centerY.equalTo(nameLabel)
      $0.leading.equalTo(nameLabel.snp.trailing).offset(margins / 3)
    }
    
    recommendCountLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(margins / 3)
      $0.leading.equalTo(contentView).offset(margins)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    commentsCountLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(margins / 3)
      $0.leading.equalTo(recommendCountLabel.snp.trailing).offset(margins)
      $0.bottom.equalTo(contentView).offset(-margins)
    }
    
    favoriteButton.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(enterImageView.snp.leading)
      $0.width.height.equalTo(44)
    }
    
    enterImageView.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView).offset(-margins * 2)
      $0.width.height.equalTo(44)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension LectureSummaryCell {
  @objc private func touchUpFavoriteButton(_ sender: UIButton) {
    delegate?.favoriteSummary(summaryID: 0, sender: sender)
  }
}
