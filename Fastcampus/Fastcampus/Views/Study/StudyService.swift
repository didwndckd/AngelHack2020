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
  
  
  class func getStudy(completion: @escaping () -> Void) {
    Firestore.firestore().collection("Study").getDocuments { (snapshot, error) in
      if let error = error {
        print(error.localizedDescription)
        
      } else {
        guard let documents = snapshot?.documents else { return }
        
        for documnet in documents {
          do {
            let model = try FirestoreDecoder().decode(StudyModel.self, from: documnet.data())
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


