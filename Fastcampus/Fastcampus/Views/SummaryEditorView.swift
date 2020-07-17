//
//  SummaryEditorView.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SummaryEditorView: View, KeyboardControllable {
  private let summaryScrollView = UIScrollView()
  private let titleLabel = UILabel()
  private let titleTextField = DisignableTextField(placeHolder: "제목을 입력해 주세요.")
  private let contextLabel = UILabel()
  private let contextTextView = UITextView()
  private let summaryCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  private let cancelButton = UIButton()
  private let registButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func handleKeyboardWillShow(_ notification: Notification) {
    let keyboardHeight = notification.keyboardSize?.height ?? 250
    cancelButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-keyboardHeight)
    }
    
    registButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-keyboardHeight)
    }
    
    layoutIfNeeded()
  }
  
  func handleKeyboardWillHide(_ notification: Notification) {
    cancelButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
    }
    
    registButton.snp.updateConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
    }
    
    layoutIfNeeded()
  }
  
  override func attribute() {
    super.attribute()
    titleLabel.text = "제목"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    contextLabel.text = "내용"
    contextLabel.textColor = .black
    contextLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    contextTextView.layer.cornerRadius = 8
    contextTextView.layer.borderWidth = 1
    contextTextView.layer.borderColor = UIColor.lightGray.cgColor
    contextTextView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    summaryCollectionView.dataSource = self
    summaryCollectionView.delegate = self
    summaryCollectionView.register(SummaryEditorCell.self, forCellWithReuseIdentifier: SummaryEditorCell.identifier)
    
    cancelButton.setTitle("취소", for: .normal)
    cancelButton.setTitleColor(.gray, for: .normal)
    cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    cancelButton.backgroundColor = #colorLiteral(red: 0.9112721086, green: 0.9109323621, blue: 0.9292862415, alpha: 1)
    
    registButton.setTitle("요약본 올리기", for: .normal)
    registButton.setTitleColor(.white, for: .normal)
    registButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    registButton.backgroundColor = UIColor.myRed
  }
  
  override func setupUI() {
    super.setupUI()
    let guide = self.safeAreaLayoutGuide
    let margins: CGFloat = 15
    
    [titleLabel, titleTextField, contextLabel, contextTextView, summaryCollectionView, cancelButton, registButton]
      .forEach { self.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top).offset(margins)
      $0.leading.equalTo(self).offset(margins)
    }
    
    titleTextField.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
      $0.height.equalTo(44)
    }
    
    contextLabel.snp.makeConstraints {
      $0.top.equalTo(titleTextField.snp.bottom).offset(margins)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
    }
    
    contextTextView.snp.makeConstraints {
      $0.top.equalTo(contextLabel.snp.bottom).offset(margins / 2)
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
      $0.bottom.equalTo(summaryCollectionView.snp.top).offset(-margins / 2)
    }
    
    summaryCollectionView.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margins)
      $0.trailing.equalTo(self).offset(-margins)
      $0.bottom.equalTo(cancelButton.snp.top).offset(-margins)
      $0.height.equalTo(80)
    }
    
    cancelButton.snp.makeConstraints {
      $0.leading.equalTo(self)
      $0.bottom.equalTo(guide.snp.bottom)
      $0.height.equalTo(56)
    }
    
    registButton.snp.makeConstraints {
      $0.leading.equalTo(cancelButton.snp.trailing)
      $0.trailing.equalTo(self)
      $0.bottom.equalTo(guide.snp.bottom)
      $0.height.equalTo(56)
      $0.width.equalTo(cancelButton)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SummaryEditorView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryEditorCell.identifier, for: indexPath) as! SummaryEditorCell
    return cell
  }
  
}

extension SummaryEditorView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 2, height: 80)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
}
