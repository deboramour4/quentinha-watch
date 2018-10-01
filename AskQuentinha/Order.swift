//
//  Order.swift
//  AskQuentinha
//

import Foundation

class Order {
    var meal: Meal?
    var paymentType: String?
}

struct Meal {
    var guarnish: String
    var mainMeal: String
}
