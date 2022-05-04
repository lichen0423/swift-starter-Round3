//
//  Week3Step1.swift
//  CodeStarterCamp_Week3
//
//  Created by mingmac on 2022/05/01.
//

import Foundation

class Person {
    let name: String
    var money: Int = 10000
    var job: String?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, job: String) {
        self.name = name
        self.job = job
    }
    
    deinit {
        print("[안내] \(name)님이 카페를 나갑니다.")
    }
    
    func buy(kindOf drink: Coffee, at cafe: CoffeeShop) {
        cafe.order(drink, for: self)
    }
}
