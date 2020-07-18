//
//  DecodedExtension.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/19.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    func decoded<Type: Decodable>() throws -> Type {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(Type.self, from: jsonData)
        return object
    }
}

extension QuerySnapshot {
    func decoded<Type: Decodable>() throws -> [Type] {
        let objects: [Type] = try documents.map({try $0.decoded() })
        return objects
    }
}
