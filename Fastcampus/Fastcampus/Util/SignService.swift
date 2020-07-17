//
//  SignService.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class SignService {
  
  static var user: UserModel!
  
  class func signIn(email: String, password: String, completion: @escaping () -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, _) in
      guard let uid = result?.user.uid else { return }
      Firestore
        .firestore()
        .collection("User")
        .document(uid)
        .getDocument { (snapshot, error) in
          guard let data = snapshot?.data() else { return }
          let model = try! FirestoreDecoder().decode(UserModel.self, from: data)
          user = model
          completion()
      }
    }
  }
}
