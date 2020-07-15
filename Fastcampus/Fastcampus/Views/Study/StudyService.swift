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

struct TempStudy: Codable {
  let title: String
  let date: Date
  let rule: String
  var userIDs: [String]?
  var qnaIDs: [String]?
  var inProcess: ProcessStatus
  
  enum ProcessStatus: Int, Codable {
    case wait
    case inProcess
    case finished
  }
}

class StudyService {
  
  
  class func getStudy(completion: @escaping () -> Void) {
    Firestore.firestore().collection("Study").getDocuments { (snapshot, error) in
      if let error = error {
        print(error.localizedDescription)
        
      } else {
        guard let documents = snapshot?.documents else { return }
        
        for documnet in documents {
          do {
            let model = try FirebaseDecoder().decode(TempStudy.self, from: documnet.data())
            print(model)
            
            
          } catch {
            print("Error")
            print(error)
          }
        }
      }
    }
  }
}

extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}
