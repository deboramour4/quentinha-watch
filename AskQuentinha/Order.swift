//
//  Order.swift
//  AskQuentinha
//

import Foundation

class Order {
    
    static var current = Order()
    
    private init() { }
    
    var garnish: String?
    var mainMeal: String?
    var paymentType: String?
    
    func transformToDict() -> [String: Any] {
        return [
            "garnish": self.garnish ?? "",
            "mainMeal": self.mainMeal ?? "",
            "paymentType": self.paymentType ?? ""
        ]
    }
    
    static func transformToObject(order dict: [String: Any]) -> Order {
        let order = Order()
        order.garnish = dict["garnish"] as? String
        order.mainMeal = dict["mainMeal"] as? String
        order.paymentType = dict["paymentType"] as? String
        return order
    }
}
