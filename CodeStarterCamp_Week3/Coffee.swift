//
//  Coffee.swift
//  CodeStarterCamp_Week3
//
//  Created by ChoiKwangWoo on 2023/06/02.
//

import Foundation

/*
 1. Person 타입을 정의합니다.
  - 사람이 공통적으로 가지는 특성을 프로퍼티로 정의해봅시다.
    돈이라는 속성을 가질 수 있도록 해봅시다.
  - 사람이 공통적으로 할 수 있는 동작을 메서드로 정의해봅시다.
    커피를 구매할 수 있도록 메서드를 정의해봅시다.
 */
class Person {
    var name: String
    var gender: Gender
    var MBTI: String
    var age: Int
    private var currentMoney: Int = 15_000
    
    init(name: String, gender: Gender, MBTI: String, age: Int) {
        self.name = name
        self.gender = gender
        self.MBTI = MBTI
        self.age = age
    }
    
    enum Gender {
        case man
        case woman
    }
    
    func orderCoffee(menu: Coffee, of coffeeShop: CoffeeShop, by name: String) {
        let currentMoneyAfterOrder = self.currentMoney - menu.price
        guard currentMoneyAfterOrder > 0 else {
            print("잔액이 \(-(currentMoneyAfterOrder))원 만큼 부족합니다.")
            return
        }
        coffeeShop.make(coffee: menu, for: name)
        self.currentMoney = currentMoneyAfterOrder
    }
    
    func spendMoney(price: Int) {
        self.currentMoney -= price
    }
    
    func makeMoney(salary: Int) {
        self.currentMoney += salary
    }
    
    func selfIntroduce() {
        print("제 이름은 \(self.name)구요. 나이는 \(self.age)살, MBTI는 \(self.MBTI)입니다.")
    }
    
    func walk() {
        print("걷는다")
    }
    
    func showCurrentMoney() {
        print("현재 잔액: \(self.currentMoney)")
    }
}

/*
 2. CoffeeShop 타입을 생성합니다.
  - 카페들이 공통적으로 가지는 특성을 프로퍼티로 정의해봅시다.
    매출액을 속성으로 가질 수 있도록 해봅시다.
  - 메뉴판(커피 종류, 가격)을 가질 수 있도록 해봅시다.
    pickUpTable 을 가질 수 있도록 해봅시다.
    pickUpTable은 Coffee를 담을 수 있는 배열입니다.
  - 카페들이 공통적으로 할 수 있는 동작을 메서드로 정의해봅시다.
    주문을 받고, 커피를 만들어낼 수 있는 동작을 가질 수 있도록 해봅시다.
    커피를 만들면 pickUpTable 에 할당할 수 있도록 해봅시다.
 */
class CoffeeShop {
    private var coffeeShopName: String
    private var totalSales: Int
    private var coffeeMenu: [String: String]
    private var pickUpTable: [Coffee]
    private var barista: Person
    
    init(coffeeShopName: String, totalSales: Int, coffeeMenu: [String : String], pickUpTable: [Coffee], barista: Person) {
        self.coffeeShopName = coffeeShopName
        self.totalSales = totalSales
        self.coffeeMenu = coffeeMenu
        self.pickUpTable = pickUpTable
        self.barista = barista
    }
    
    func receivedOrder(coffee menu: Coffee) {
        print("\(menu.name) 메뉴가 접수되었습니다!")
        self.pickUpTable.append(menu)
        self.totalSales += menu.price
    }
    
    func make(coffee: Coffee, for name: String) {
        self.pickUpTable.append(coffee)
        print("\(name) 님이 주문하신 \(coffee.name)(이/가) 준비되었습니다. 픽업대에서 가져가주세요.")
        self.totalSales += coffee.price
    }
    
    func change(barista: Person) {
        print("바리스타가 \(self.barista.name)님의 퇴사로 \(barista.name)님으로 변경되었습니다.")
        self.barista = barista
    }
    
    func showCoffeeMenu() {
        print("------메뉴------")
        for (index, coffee) in self.coffeeMenu.enumerated() {
            print("\(index+1). \(coffee.key)\t\(coffee.value)")
        }
        print("---------------")
    }
    
    func showPickUpTable() {
        print(self.pickUpTable)
    }
    
    func showTotalSale() {
        print(self.totalSales)
    }
}

/*
 3. Coffee 타입(열거형)을 생성합니다.
    커피의 여러 종류들을 case로 가질 수 있도록 해봅시다.
 */
enum Coffee: CaseIterable {
    case espresso
    case americano
    case latte
    case ade
    
    var name: String {
        switch self {
        case .espresso: return "에스프레소"
        case .americano: return "아메리카노"
        case .latte: return "라떼"
        case .ade: return "에이드"
        }
    }
    
    var price: Int {
        switch self {
        case .espresso: return 2000
        case .americano: return 2000
        case .latte: return 4000
        case .ade: return 4500
        }
    }
}

func getCoffeeMenus() -> [String: String] {
    var coffeeMenus: [String: String] = [:]
    Coffee.allCases.forEach{ coffee in
        coffeeMenus[coffee.name] = "\(coffee.price)원"
    }
    return coffeeMenus
}
