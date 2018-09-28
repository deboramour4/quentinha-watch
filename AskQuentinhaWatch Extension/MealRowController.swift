//
//  MealRowController.swift
//  AskQuentinhaWatch Extension
//
//  Created by Ada 2018 on 28/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

class MealRowController: NSObject {
    @IBOutlet var mainMealLabel: WKInterfaceLabel!
    @IBOutlet var garnishLabel: WKInterfaceLabel!

    var mainMeal: String? {
        didSet {
            mainMealLabel.setText(mainMeal)
        }
    }

    var garnish: String? {
        didSet {
            garnishLabel.setText(garnish)
        }
    }



}
