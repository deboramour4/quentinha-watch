//
//  MealInterfaceController.swift
//  AskQuentinhaWatch Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation


class MealInterfaceController: WKInterfaceController {

    @IBOutlet var garnishTable: WKInterfaceTable!
    @IBOutlet var mainMealTable: WKInterfaceTable!

    var garnishs = ["Arroz", "Baião"]
    var mainMeals = ["Frango", "Carne", "Soja"]

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        //Set number rows in tables
        garnishTable.setNumberOfRows(garnishs.count, withRowType: "GarnishRow")
        mainMealTable.setNumberOfRows(mainMeals.count, withRowType: "MainMealRow")

        //Complete table rows data
        for index in 0..<garnishTable.numberOfRows {
            guard let controller = garnishTable.rowController(at: index) as? MealRowController else { continue }
            controller.garnish = garnishs[index]
        }

        for index in 0..<mainMealTable.numberOfRows {
            guard let controller = mainMealTable.rowController(at: index) as? MealRowController else { continue }
            controller.mainMeal = mainMeals[index]
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
