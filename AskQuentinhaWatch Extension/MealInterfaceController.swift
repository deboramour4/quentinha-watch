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

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
