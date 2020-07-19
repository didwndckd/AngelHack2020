//
//  SummaryVC.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SummaryVC: UITableViewController {
  private let db = Firestore.firestore()
  private var summary: Summary? {
    didSet {
      self.tableView.reloadData()
    }
  }
  private let lecture: Lecture
  private let chapter: ChapterModel
  private let unit: UnitModel
  
  init(lecture: Lecture, chapter: ChapterModel, unit: UnitModel, summary: Summary? = nil) {
    self.lecture = lecture
    self.chapter = chapter
    self.unit = unit
    self.summary = summary
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  private func attribute() {
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    self.view.isUserInteractionEnabled = true
    self.view.backgroundColor = .white

    self.tableView = UITableView(frame: .zero, style: .grouped)
    self.tableView.bounces = false
    self.tableView.separatorStyle = .none
    self.tableView.backgroundColor = #colorLiteral(red: 0.9452976584, green: 0.9455571771, blue: 0.9636406302, alpha: 1)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(CommentInputCell.self, forCellReuseIdentifier: CommentInputCell.identifier)
    self.tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let comments = summary?.comments {
      return comments.count + 1
    } else {
      return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: CommentInputCell.identifier, for: indexPath) as!
      CommentInputCell
      cell.delegate = self
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.identifier, for: indexPath) as! SummaryCell
      let comment = summary!.comments![indexPath.row - 1]
      cell.setProperties(comment: comment)
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let summary = summary,
          let allUser = UserService.allUser else { return nil }
    let user = allUser.filter { $0.uid == summary.userID }.first!
    let summaryHeaderView = SummaryHeaderView()
    summaryHeaderView.setProperties(summary: summary, user: user)
    summaryHeaderView.delegate = self
    return summaryHeaderView
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SummaryVC: CommentInputCellDelegate {
  func addcomment(text: String?) {
    //TODO:- 댓글 추가
//    let commentsData = summary!.comments
//    print("asdfasdasdf")
    let summaryRefer = db.collection("Summary")
      .document("\(lecture.id)")
      .collection("\(chapter.index)")
      .document(summary!.documentID!)
    
    Firestore.firestore().runTransaction({ (transAction, errorPointer) -> Any? in
      let tempDocument: DocumentSnapshot
      do {
        try tempDocument = transAction.getDocument(summaryRefer)
        
      } catch let error as NSError {
        debugPrint("Fetch error : ", error.localizedDescription)
        return nil
      }
      
      guard
        let data = tempDocument.data(),
        var comments = data["comments"] as? [String]
        else { return nil }
      
      comments.append(text!)
      
      transAction.updateData(["comments": comments], forDocument: summaryRefer)
      
      return nil
      
    }) { (_, _) in }
    
    
    print("[Log] :", text ?? "")
  }
}

private extension SummaryVC {
  @objc private func didTap() {
    self.view.endEditing(true)
  }
}

extension SummaryVC: SummaryHeaderViewDelegate {
  func isFavorite(sender: UIButton) {
    sender.isSelected.toggle()
    let image = sender.isSelected ? #imageLiteral(resourceName: "icon_favorite_selected") : #imageLiteral(resourceName: "icon_favorite_deselected")
    sender.setImage(image, for: .normal)
    
  }
}
