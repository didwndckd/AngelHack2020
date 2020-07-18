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
  
  class func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      guard error == nil else {
        completion(false)
        return
      }
      
      guard let uid = result?.user.uid else { return }
      Firestore
        .firestore()
        .collection("User")
        .document(uid)
        .getDocument { (snapshot, error) in
          if let error = error {
            print("SignIn", error.localizedDescription)
            completion(false)
            
          } else {
            guard let data = snapshot?.data() else { return }
            let model = try! FirestoreDecoder().decode(UserModel.self, from: data)
            user = model
            
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            
            completion(true)
          }
          
      }
    }
  }
  
  
  class func signOut() throws {
    try Auth.auth().signOut()
  }
}

