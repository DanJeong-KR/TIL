
import Foundation

struct MenuData {
    let category: String
    let products: [Product]
}

struct Product {
    let name: String
    let price: Int
}

let menuDatas: [MenuData] = [
    MenuData(category: "슈퍼시드", products: [
        Product(name: "글램핑 바비큐", price: 35900),
        Product(name: "알로하 하와이안", price: 25900),
        Product(name: "우리 고구마", price: 31900),
        Product(name: "콰트로 치즈 퐁듀", price: 25900)
        ]
    ),
    MenuData(category: "프리미엄", products: [
        Product(name: "더블크러스트 이베리코", price: 34900),
        Product(name: "블랙앵거스 스테이크", price: 25900),
        Product(name: "블랙타이거 슈림프", price: 31900),
        Product(name: "와규 앤 비스테카", price: 25900),
        Product(name: "직화 스테이크", price: 25900)
        ]
    ),
    MenuData(category: "클래식", products: [
        Product(name: "포테이토", price: 25900),
        Product(name: "슈퍼디럭스", price: 25900),
        Product(name: "슈퍼슈프림", price: 25900),
        Product(name: "베이컨체더치즈", price: 25900),
        Product(name: "불고기", price: 24900),
        Product(name: "페퍼로니", price: 22900)
        ]
    ),
    MenuData(category: "사이드디시", products: [
        Product(name: "딸기 슈크림", price: 4800),
        Product(name: "슈퍼곡물 치킨", price: 7800),
        Product(name: "애플 크러스트 디저트", price: 3800),
        Product(name: "치킨퐁듀 그라탕", price: 8800),
        Product(name: "퀴노아 치킨 샐러드", price: 7800),
        Product(name: "포테이토 순살치킨", price: 7800)
        ]
    ),
    MenuData(category: "음료", products: [
        Product(name: "미닛메이드 스파클링 청포도", price: 2300),
        Product(name: "스프라이트", price: 2100),
        Product(name: "코카콜라", price: 2000),
        Product(name: "코카콜라 제로", price: 2100)
        ]
    ),
    MenuData(category: "피클소스", products: [
        Product(name: "갈릭 디핑 소스", price: 200),
        Product(name: "스위트 칠리소스", price: 300),
        Product(name: "우리 피클 L", price: 800),
        Product(name: "우리 피클 M", price: 500),
        Product(name: "핫소스", price: 100)
        ]
    )
]


