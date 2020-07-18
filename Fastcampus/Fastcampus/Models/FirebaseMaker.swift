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
//    unit6.forEach {
//      let data = try! FirestoreEncoder().encode($0)
//      Firestore.firestore().collection("Lecture").document("QEULxiXwlzDu5nOsH7Kl").collection("Chapter").document("6").collection("Units").document(String($0.index)).setData(data)
//    }
//  }

//  private static let unit1 = [
//    UnitModel(title: "스위프트 언어의 탄생과 배경", index: 1, description: "스위프트는 애플이 2014 세계 개발자 대회에서 발표한 iOS나 macOS 앱 개발의 새로운 언어입니다. 그동안 앱을 개발하는 데에 사용되던 오브젝티브-C 를 대체할 목적으로 발표된 언어죠", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "스위프트 언어의 특징", index: 2, description: "WWDC 2014 에서 발표한 스위프트의 개발 생산성과 앱 성능에 대한 포지셔닝 그래프 입니다. 상대적으로 언어에 대한 진입 장벽이 낮고 개발하기 쉬운 자바스크립트나 파이썬, 루비와 같은 동적 바인딩 타입의 언어는 생산성이 좋지만 성능이 부족한 경유가 많고, 성능이 좋은 언어일수록 진입 장벽이 높고 개발하기 어려워 생산성이 낮은 경우가 많습니다.", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "오브젝티브-C vs 스위프트", index: 3, description: "오브젝티브-C 는 20여 년 동안 애플의 주력 개발 언어로 사용되었던 만큼 튼튼한 아키텍처와 검증된 성능을 가지고 있습니다. 이런 오브젝티브-C 를 대체할 목적으로 스위프트가 출현했을 때 많은 사람의 관심은 과연 스위프트가 오브젝티브-C 를 대체할 수 있까였죠.", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]

//  private static let unit2 = [
//    UnitModel(title: "통합개발 환경", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode란?", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode 설치하기", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode 실행하기", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode의 구성요소", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "앱 시뮬레이터", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Xcode 제약 사항", index: 7, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]

//  private static let unit3 = [
//    UnitModel(title: "스위프트 기초 문법", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "변수와 상수", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "자료형", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "연산자", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]

//  private static let unit4 = [
//    UnitModel(title: "반복문", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "조건문", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "제어 전달문", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]

//  private static let unit5 = [
//    UnitModel(title: "배열", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "집합", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "튜플", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "딕셔너리", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]

//  private static let unit6 = [
//    UnitModel(title: "옵서널 타입 선언과 정의", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널 강제 해제", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널 바인딩", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널 컴파일러에 의한 옵셔널 자동 해제", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "옵셔널의 묵시적 해제", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//  ]
}




extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}
