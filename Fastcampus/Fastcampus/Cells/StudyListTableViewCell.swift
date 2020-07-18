//
//  StudyListTableViewCell.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class StudyListTableViewCell: UITableViewCell {

  static let identifier = "StudyListTableViewCell"
  
  private let baseView = UIView()
  private let gradientView = UIView()
  
  private let lectureLabel = UILabel()
  private let unitLabel = UILabel()
  
  private let badgeLabel = BadgeLabel()
  private let masterLabel = UILabel()
  private let titleLabel = UILabel()
  private let dateLabel = UILabel()
  private let fixedLabel = UILabel()
  private let arrowImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(data: StudyModel) {
    lectureLabel.text = data.lectureTitle
    unitLabel.text = data.unitTitle
    badgeLabel.text = "Lv.2"
    UserService.getData(uid: data.userIDs[0]) { (result) in
      switch result {
      case .failure: break
      case .success(let data):
        self.masterLabel.text = data.nickName
      }
    }
    titleLabel.text = data.title
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MM.dd hh:mm"
    let stringDate = formatter.string(from: data.dateValue)
    dateLabel.text = "  " + stringDate + " 시작" + "  "
    
    let currentUserCount = data.userIDs.count
    fixedLabel.text = "\(currentUserCount)명 / \(data.fixed)명"
  }
  
  private func setUI() {
    self.selectionStyle = .none
    
    
    baseView.layer.cornerRadius = 4
    baseView.backgroundColor = .white
    baseView.shadow()
    
    let gradient = CAGradientLayer()
    gradient.startPoint = CGPoint(x: 0, y: 1)
    gradient.endPoint = CGPoint(x: 1, y: 1)
    gradient.colors = [
      #colorLiteral(red: 0.9294117647, green: 0.1490196078, blue: 0.3137254902, alpha: 1).cgColor,
      #colorLiteral(red: 0.9921568627, green: 0.4549019608, blue: 0.3137254902, alpha: 1).cgColor
    ]
    gradient.locations = [0, 1]
    gradient.frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 46))
    gradient.superlayer?.cornerRadius = 4
    gradientView.layer.addSublayer(gradient)
    gradientView.layer.cornerRadius = 4
    gradientView.layer.masksToBounds = true
    gradientView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    
    
    lectureLabel.font = .systemFont(ofSize: 14, weight: .black)
    unitLabel.font = .systemFont(ofSize: 12)
    
    [lectureLabel, unitLabel].forEach {
      $0.textColor = .white
    }
    
    badgeLabel.font = .systemFont(ofSize: 12)
    
    masterLabel.textColor = .darkGray
    masterLabel.font = .boldSystemFont(ofSize: 17)
    
    titleLabel.font = .boldSystemFont(ofSize: 17)
    
    dateLabel.backgroundColor = .myGray
    
    
    arrowImageView.image = UIImage(systemName: "chevron.right")
    arrowImageView.contentMode = .left
    
  }
  
  private func setConstraint() {
    [baseView, gradientView,
     lectureLabel, unitLabel,
     badgeLabel, masterLabel,
     titleLabel,
     dateLabel, fixedLabel,
     arrowImageView
      ].forEach {
        contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let xInset: CGFloat = 16
    let yInset: CGFloat = 8
    let xSpace: CGFloat = 16
    let ySpace: CGFloat = 8
    let toSpace: CGFloat = 4
    
    NSLayoutConstraint.activate([
      baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: yInset),
      baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xInset),
      baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xInset),
      baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -yInset),
      
      gradientView.topAnchor.constraint(equalTo: baseView.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
      gradientView.heightAnchor.constraint(equalToConstant: 56),
      
      lectureLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      lectureLabel.bottomAnchor.constraint(equalTo: gradientView.centerYAnchor),
      
      unitLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      unitLabel.topAnchor.constraint(equalTo: gradientView.centerYAnchor),
      
      badgeLabel.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: ySpace),
      badgeLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      masterLabel.centerYAnchor.constraint(equalTo: badgeLabel.centerYAnchor),
      masterLabel.leadingAnchor.constraint(equalTo: badgeLabel.trailingAnchor, constant: toSpace),
      
      titleLabel.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: toSpace),
      titleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: toSpace),
      dateLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xSpace),
      dateLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -ySpace),
      
      fixedLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
      fixedLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: toSpace),
      
      arrowImageView.topAnchor.constraint(equalTo: gradientView.bottomAnchor),
      arrowImageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
      arrowImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
      arrowImageView.widthAnchor.constraint(equalToConstant: 32)
    ])
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    
  }
  
}
