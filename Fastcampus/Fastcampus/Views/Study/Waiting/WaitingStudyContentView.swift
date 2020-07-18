//
//  WaitingStudyDescriptionView.swift
//  Fastcampus
//
//  Created by 양중창 on 2020/07/14.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class WaitingStudyContentView: View {
  
  
  private let scrollView = UIScrollView()
  private let lectureTitleLabel = UILabel()
  private let unitTitleLabel = UILabel()
  private let upperLine = UIView()
  
  private let masterUserLabel = StudyInformationView(isLongType: false, title: "방장")
  private let studyTitleLabel = StudyInformationView(isLongType: false, title: "제목")
  private let fixedLable = StudyInformationView(isLongType: false, title: "정원")
  private let unitDescriptionLabel = StudyInformationView(isLongType: true, title: "강의 정보")
  private let studyRuleLabel = StudyInformationView(isLongType: true, title: "스터디 규칙")
  
  
  
  override func attribute() {
    super.attribute()
    
    lectureTitleLabel.font = .systemFont(ofSize: 17, weight: .black)
    lectureTitleLabel.textColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    lectureTitleLabel.textAlignment = .center
    
    unitTitleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    unitTitleLabel.textColor = #colorLiteral(red: 0.6431372549, green: 0.6431372549, blue: 0.662745098, alpha: 1)
    unitTitleLabel.textAlignment = .center
    
    upperLine.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
    
    
    
  }
  
  override func setupUI() {
    super.setupUI()
    [lectureTitleLabel, unitTitleLabel, upperLine, scrollView].forEach({
      addSubview($0)
    })
    
    let topMargin: CGFloat = 16
    let bottomMargin: CGFloat = 32
    let xMargin: CGFloat = 32
    
    let topPadding: CGFloat = 8
    
    lectureTitleLabel.snp.makeConstraints({
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(xMargin)
    })
    
    unitTitleLabel.snp.makeConstraints({
      $0.top.equalTo(lectureTitleLabel.snp.bottom).offset(topPadding)
      $0.leading.trailing.equalToSuperview().inset(xMargin)
    })
    
    upperLine.snp.makeConstraints({
      $0.height.equalTo(1)
      $0.leading.trailing.equalTo(scrollView)
      $0.bottom.equalTo(scrollView.snp.top)
    })
    
    scrollView.snp.makeConstraints({
      $0.top.equalTo(unitTitleLabel.snp.bottom).offset(topMargin)
      $0.leading.trailing.equalToSuperview().inset(xMargin)
      $0.bottom.equalToSuperview()
    })
    
    let labels = [masterUserLabel, studyTitleLabel, fixedLable, unitDescriptionLabel, studyRuleLabel]
    
    labels.enumerated().forEach({ index, label in
      let top = index == 0 ? scrollView.snp.top: labels[index - 1].snp.bottom
      scrollView.addSubview(label)
      label.snp.makeConstraints({
        $0.top.equalTo(top).offset(topPadding)
        $0.leading.trailing.equalToSuperview()
        $0.width.equalToSuperview()
        
        if index == labels.count - 1 {
          $0.bottom.equalToSuperview().offset(-bottomMargin)
        }
        
      })
    })
    
  }
  
  func configure(study: StudyModel) {
    lectureTitleLabel.text = study.lectureTitle
    unitTitleLabel.text = study.unitTitle
    masterUserLabel.configure(description: study.userIDs.first)
    studyTitleLabel.configure(description: study.title)
    fixedLable.configure(description: "\(study.userIDs.count)/\(study.fixed)")
    unitDescriptionLabel.configure(description: study.unitDescription)
    studyRuleLabel.configure(description: study.rule)
  }
  
  
}
