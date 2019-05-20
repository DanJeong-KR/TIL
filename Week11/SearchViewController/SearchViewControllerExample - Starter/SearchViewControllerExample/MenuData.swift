//
//  MenuData.swift
//  SearchViewControllerExample
//
//  Created by Wi on 12/05/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation

struct Product {
    let name: String
    var price: Int
}

struct MenuData {
    var category: String
    var menu : [Product]
}

let menuData: [MenuData] = [
    MenuData(category: "슈퍼시드", menu: [
        Product(name: "글램핑 바비큐", price: 10000),
        Product(name: "알로하 하와이안", price: 10000),
        Product(name: "우리 고구마", price: 10000),
        Product(name: "콰트로 치즈 퐁듀", price: 10000)
        
        ]),
    MenuData(category: "클래식", menu: [
        Product(name: "포테이토", price: 10000),
        Product(name: "슈퍼디럭스", price: 10000),
        Product(name: "슈퍼슈프림", price: 10000),
        Product(name: "베이컨체더치즈", price: 10000),
        Product(name: "불고기", price: 10000),
        Product(name: "페퍼로니", price: 10000)
        ]),
    MenuData(category: "프리미엄", menu: [
        Product(name: "더블크러스트 이베리코", price: 10000),
        Product(name: "블랙앵거스 스테이크", price: 10000),
        Product(name: "블랙타이거 슈림프", price: 10000),
        Product(name: "와규 앤 비스테카", price: 10000),
        Product(name: "직화 스테이크", price: 10000)
        
        ]),
    MenuData(category: "사이드", menu: [
        Product(name: "딸기 슈크림", price: 7000),
        Product(name: "슈퍼곡물 치킨", price: 7000),
        Product(name: "애플 크러스트 디저트", price: 7000),
        Product(name: "치킨퐁듀 그라탕", price: 7000),
        Product(name: "퀴노아 치킨 샐러드", price: 7000),
        Product(name: "포테이토 순살치킨", price: 7000),
        
        ]),
    MenuData(category: "음료", menu: [
        Product(name: "미닛메이드 스파클링 청포도", price: 3000),
        Product(name: "스프라이트", price: 3000),
        Product(name: "코카콜라", price: 3000),
        Product(name: "코카콜라 제로", price: 3000)
        ]),
    MenuData(category: "피클소스", menu: [
        Product(name: "갈릭 디핑 소스", price: 500),
        Product(name: "스위트 칠리소스", price: 500),
        Product(name: "우리 피클 L", price: 500),
        Product(name: "우리 피클 M", price: 500),
        Product(name: "핫소스", price: 500)
        ])
]
