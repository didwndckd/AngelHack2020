//
//  StudyService.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/15.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class StudyService {
  
  class func createStudy(studyModel: StudyModel, completion: @escaping () -> Void) {
    guard let model = try? FirestoreEncoder().encode(studyModel) else { return }
    
    let studyDocumenID = Firestore
      .firestore()
      .collection("Study")
      .addDocument(data: model) { (error) in
        completion()
    }.documentID
    
    let unitDocuemnt = Firestore
      .firestore()
      .collection("Lecture")
      .document(studyModel.lectureID)
      .collection("Chapter")
      .document(String(studyModel.chapterID))
      .collection("Units")
      .document(String(studyModel.unitID))
    
      
    Firestore.firestore().runTransaction({ (transAction, errorPointer) -> Any? in
      let tempDocument: DocumentSnapshot
      do {
        try tempDocument = transAction.getDocument(unitDocuemnt)
        
      } catch let error as NSError {
        debugPrint("Fetch error : ", error.localizedDescription)
        return nil
      }
      
      guard
        let data = tempDocument.data(),
        var studys = data["studyIDs"] as? [String]
        else { return nil }
      
      studys.append(studyDocumenID)
      SignService.user.studys.append(studyDocumenID)
      
      transAction.updateData(["studyIDs": studys], forDocument: unitDocuemnt)
      
      return nil
      
    }) { (_, _) in }
    
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let userDocuemnt = Firestore
      .firestore()
      .collection("User")
      .document(uid)
    
    Firestore.firestore().runTransaction({ (transAction, errorPointer) -> Any? in
      let tempDocument: DocumentSnapshot
      do {
        try tempDocument = transAction.getDocument(userDocuemnt)
        
      } catch let error as NSError {
        debugPrint("Fetch error : ", error.localizedDescription)
        return nil
      }
      
      guard
        let data = tempDocument.data(),
        var studys = data["studys"] as? [String]
        else { return nil }
      
      studys.append(studyDocumenID)
      
      transAction.updateData(["studys": studys], forDocument: userDocuemnt)
      
      return nil
      
    }) { (_, _) in }

    
  }
  
  class func getStudy(studyDocumentID: String, completion: @escaping (Result<StudyModel, Error>) -> Void) {
    Firestore
      .firestore()
      .collection("Study")
      .document(studyDocumentID)
      .getDocument { (snapshot, error) in
        
        if let error = error {
          completion(.failure(error))
          
        } else {
          guard
            let data = snapshot?.data(),
            let model = try? FirestoreDecoder().decode(StudyModel.self, from: data)
            else {
              completion(.failure(NSError(domain: "Parsing Errro", code: 0)))
              return
          }
          
          completion(.success(model))
        }
    }
  }
  
  
  class func join(documnetID: String, completion: @escaping () -> Void) {
    Firestore
      .firestore()
      .collection("Study")
      .document(documnetID)
  }
  
  
  
  class func qnaUpdate(model: QnAModel) {
    guard let data = try? FirestoreEncoder().encode(model) else { return }
    
    Firestore
      .firestore()
      .collection("QnA")
      .addDocument(data: data)
  }
  
  
  private static var qnaListener: ListenerRegistration?
  
  class func qnaAddListener(studyDocumentID: String, completion: @escaping ([QnA]) -> Void) {
    qnaListener = Firestore
      .firestore()
      .collection("QnA")
      .whereField("studyDocumentID", isEqualTo: studyDocumentID)
      .addSnapshotListener { (snapshot, _) in
        guard let documents = snapshot?.documents else { return }

        var arr = [QnA]()
        
        for document in documents {
          let data = try! FirestoreDecoder().decode(QnAModel.self, from: document.data())
          let temp = QnA(documentID: document.documentID, data: data)
          arr.append(temp)
        }
        
        completion(arr)
    }
  }
  
  class func getQnaList(studyDocumentID: String, completion: @escaping ([QnA]) -> Void) {
    Firestore
      .firestore()
      .collection("QnA")
      .whereField("studyDocumentID", isEqualTo: studyDocumentID)
      .getDocuments { (snapshot, _) in
        guard let documents = snapshot?.documents else { return }

        var arr = [QnA]()
        
        for document in documents {
          let data = try! FirestoreDecoder().decode(QnAModel.self, from: document.data())
          let temp = QnA(documentID: document.documentID, data: data)
          arr.append(temp)
        }
        
        completion(arr)
    }
  }
  
  class func qnaListenerRemove() {
    qnaListener?.remove()
  }
}


