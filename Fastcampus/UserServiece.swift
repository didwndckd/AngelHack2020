//
//  UserServiece.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase


class UserService {
  
  class func getData(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
    Firestore
      .firestore()
      .collection("User")
      .document(uid)
      .getDocument { (snapshot, error) in
      
        if let error = error {
          completion(.failure(error))
          
        } else {
          guard
            let data = snapshot?.data(),
            let model = try? FirestoreDecoder().decode(UserModel.self, from: data)
            else {
              completion(.failure(NSError(domain: "Parsing Error", code: 0)))
              return
          }
          
          completion(.success(model))
        }
    }
  
  }
  
}

