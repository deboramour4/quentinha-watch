//
//  Order.swift
//  AskQuentinha
//

import Foundation

class Order {
    
    static var current = Order()
    
    var garnish: String?
    var mainMeal: String?
    var paymentType: String?
    
    var isValid: Bool {
        return garnish == nil && mainMeal != nil && paymentType != nil
    }
    
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
