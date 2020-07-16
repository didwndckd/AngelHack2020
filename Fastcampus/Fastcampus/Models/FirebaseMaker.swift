//
//  FirebaseMaker.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class FirebaseMaker {
  
  
  
//  class func makeChapter() {
//    chapters.forEach {
//      let data = try! FirestoreEncoder().encode($0)
//      Firestore.firestore().collection("Lecture").document("QEULxiXwlzDu5nOsH7Kl").collection("Chapter").document("\($0.index)").setData(data)
//    }
//  }
//
//  private static let chapters = [
//    ChapterModel(title: "애플의 새로운 언어, 스위프트", index: 1),
//    ChapterModel(title: "Xcode와 친해지기", index: 2),
//    ChapterModel(title: "기본문법: 이것이 바로 스위프트", index: 3),
//    ChapterModel(title: "흐름 제어 구문 코드의 활용성을 높여주는 도구들", index: 4),
//    ChapterModel(title: "집단 자료형: 연관된 데이터를 손쉽게 다루기", index: 5),
//    ChapterModel(title: "옵셔널", index: 6),
//  ]
  
  
  
//  class func makeUnit() {
//    unit1.forEach {
//      let data = try! FirestoreEncoder().encode($0)
//      Firestore.firestore().collection("Lecture").document("QEULxiXwlzDu5nOsH7Kl").collection("Chapter").document("1").collection("Units").document(String($0.index)).setData(data)
//    }
//  }
//
//  private static let unit1 = [
//    UnitModel(title: "스위프트 언어의 탄생과 배경", index: 1, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "스위프트 언어의 특징", index: 2, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "오브젝티브-C vs 스위프트", index: 3, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
//
//  private static let unit2 = [
//    UnitModel(title: "통합개발 환경", index: 1, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode란?", index: 2, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode 설치하기", index: 3, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode 실행하기", index: 4, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode의 구성요소", index: 5, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "앱 시뮬레이터", index: 6, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode 제약 사항", index: 7, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
//
//  private static let unit3 = [
//    UnitModel(title: "스위프트 기초 문법", index: 1, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "변수와 상수", index: 2, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "자료형", index: 3, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "연산자", index: 4, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
//
//  private static let unit4 = [
//    UnitModel(title: "반복문", index: 1, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "조건문", index: 2, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "제어 전달문", index: 3, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
//
//  private static let unit5 = [
//    UnitModel(title: "배열", index: 1, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "집합", index: 2, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "튜플", index: 3, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "딕셔너리", index: 4, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
//
//  private static let unit6 = [
//    UnitModel(title: "옵서널 타입 선언과 정의", index: 1, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널 강제 해제", index: 2, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널 바인딩", index: 3, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널 컴파일러에 의한 옵셔널 자동 해제", index: 4, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널의 묵시적 해제", index: 5, userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
}




extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}
