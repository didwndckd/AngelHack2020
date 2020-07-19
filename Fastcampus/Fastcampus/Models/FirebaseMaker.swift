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
//      Firestore.firestore().collection("Lecture").document("8zKby3GiHExsJJ5CMf64").collection("Chapter").document("\($0.index)").setData(data)
//    }
//  }
//
//  private static let chapters = [
//    ChapterModel(title: "디지털/브랜드 마케팅 fundamental", index: 1),
//    ChapterModel(title: "인스타그램 마케팅", index: 2),
//    ChapterModel(title: "구글 애즈", index: 3),
//    ChapterModel(title: "카카오 마케팅", index: 4),
//    ChapterModel(title: "검색엔진마케팅 (SEM)", index: 5),
//    ChapterModel(title: "구글 애널리틱스", index: 6),
//  ]
  
  
//  private static let chapters = [
//    ChapterModel(title: "UX 디자인 개론", index: 1),
//    ChapterModel(title: "UX 디자인 리서치 및 서비스 기획", index: 2),
//    ChapterModel(title: "디자인 프로세스 디자인하기", index: 3),
//    ChapterModel(title: "UI 디자인", index: 4),
//    ChapterModel(title: "사용성 평가", index: 5)
//  ]
  
  

//  private static let chapters = [
//    ChapterModel(title: "애플의 새로운 언어, 스위프트", index: 1),
//    ChapterModel(title: "Xcode와 친해지기", index: 2),
//    ChapterModel(title: "기본문법: 이것이 바로 스위프트", index: 3),
//    ChapterModel(title: "흐름 제어 구문 코드의 활용성을 높여주는 도구들", index: 4),
//    ChapterModel(title: "집단 자료형: 연관된 데이터를 손쉽게 다루기", index: 5),
//    ChapterModel(title: "옵셔널", index: 6),
//  ]
  
  
  
//  class func makeUnit() {
//    unit4.forEach {
//      let data = try! FirestoreEncoder().encode($0)
//      Firestore.firestore().collection("Lecture").document("8zKby3GiHExsJJ5CMf64").collection("Chapter").document("4").collection("Units").document(String($0.index)).setData(data)
//    }
//  }
  
//  private static let unit1 = [
//    UnitModel(title: "마케팅 기초", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디지털 마케팅의 이해", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "마케터의 타입", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "마케터의 프레임워크", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "통합 디지털마케팅 계획서", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디지털 비즈니스 사고방식", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit2 = [
//    UnitModel(title: "인스타그램 소개", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "채널 운영 기본 가이드라인", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "커머스 활용", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "계정 활성화 전략", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit3 = [
//    UnitModel(title: "Google Marketing Overview", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "Google Ads 살펴보기", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "리마케팅 목록 및 태그", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "구글 태그 어시스턴스", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "검색 광고 Overview", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디스플레이 광고 운영하기", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit4 = [
//    UnitModel(title: "카카오모먼트 시작하기", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "카카오모먼트 계정 만들기", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "대시보드 기본구조", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "대시보드 광고관리 및 보고서", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "광고그룹전략설정", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "광고성과 분석", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit5 = [
//    UnitModel(title: "국내 매체별 특징 이해_네이버, 구글", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "매체별 검색광고 노출 위치 & 네트워크", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "소비자 구매 여정을 통한 SEM 기본, 과금 모델 이해", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "매체별 부가세 계산 방법", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "트랙킹 솔루션이란", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "트랙킹 솔루션 종류 안내", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "키워드 속성 안내", index: 7, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
  
  
  
  
  
  
  
  
//  private static let unit1 = [
//    UnitModel(title: "디자인 시작히기", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디자인 개요", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "기초", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디자이너의 역할과 배경", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit2 = [
//    UnitModel(title: "UX Overview 및 실무 프로세스", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "UX 리서치", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "데스크 리서치", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "필드 리서치", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "데이터 모델링", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "서비스 컨셉과 Feature 우선순위", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "서비스기획", index: 7, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit3 = [
//    UnitModel(title: "프로세스 디자인이란 무엇인가", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "구글 디자인 스프린트", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "아이디어 스피드 데이트", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "사용자 시나리오 맵핑", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit4 = [
//    UnitModel(title: "UI디자인 기초", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디자인 기초와 컨셉", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "인터페이스 디자인 기초", index: 3, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "스케치를 활용한 인터페이스 디자인", index: 4, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "컴포넌트 디자인", index: 5, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "스크린 디자인", index: 6, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "프로토타이핑", index: 7, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "디자인가이드", index: 8, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  
//  private static let unit5 = [
//    UnitModel(title: "사용성 테스트", index: 1, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]()),
//    UnitModel(title: "제이콥닐슨의휴리스틱평가", index: 2, description: "description", userIDs: [String](), studyIDs: [String](), memoIDs: [String]())
//  ]
  

  
  
  
  
  
  
  
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
