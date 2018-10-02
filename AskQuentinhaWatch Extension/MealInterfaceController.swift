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
    
    var garnishs = [("Arroz",false) , ("Baião",false),("Farofa",false) , ("Salada",false) ]
    var mainMeals = [("Frango", false), ("Carne", false), ("Soja",false)]

    var garnishSelected : String? {
        didSet {
            Order.current.garnish = garnishSelected
        }
    }
    var mainMealSelected : String? {
        didSet {
            Order.current.mainMeal = mainMealSelected
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        //Set number rows in tables
        garnishTable.setNumberOfRows(garnishs.count, withRowType: "GarnishRow")
        mainMealTable.setNumberOfRows(mainMeals.count, withRowType: "MainMealRow")

        //Complete table rows data
        for index in 0..<garnishTable.numberOfRows {
            guard let controller = garnishTable.rowController(at: index) as? GarnishRowController else { continue }
            controller.garnish = garnishs[index].0
        }

        for index in 0..<mainMealTable.numberOfRows {
            guard let controller = mainMealTable.rowController(at: index) as? MealRowController else { continue }
            controller.mainMeal = mainMeals[index].0
        }
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        if let row = table.rowController(at: rowIndex) as? GarnishRowController {
            if (garnishs[rowIndex].1) {
                //Diselect the row
                garnishSelected = nil
                garnishs[rowIndex].1 = false
                row.rowGroup.setBackgroundColor(UIColor.defaultGray)
            }
            else {
                //Check if another row is already selected
                for (index, g) in garnishs.enumerated() {
                    if (g.1){
                        garnishs[index].1 = false
                        let lastSelected = table.rowController(at: index) as? GarnishRowController
                        lastSelected?.rowGroup.setBackgroundColor(UIColor.defaultGray)
                    }
                }

                //Select the row
                garnishSelected = garnishs[rowIndex].0
                garnishs[rowIndex].1 = true
                row.rowGroup.setBackgroundColor(UIColor.darkGray)
            }
        }


        if let row = table.rowController(at: rowIndex) as? MealRowController {
            if (mainMeals[rowIndex].1) {
                //Diselect the row
                mainMealSelected = nil
                mainMeals[rowIndex].1 = false
                row.rowGroup.setBackgroundColor(UIColor.defaultGray)
            }
            else {
                //Check if another row is already selected
                for (index, g) in mainMeals.enumerated() {
                    if (g.1){
                        mainMeals[index].1 = false
                        let lastSelected = table.rowController(at: index) as? MealRowController
                        lastSelected?.rowGroup.setBackgroundColor(UIColor.defaultGray)
                    }
                }

                //Select the row
                mainMealSelected = mainMeals[rowIndex].0
                mainMeals[rowIndex].1 = true
                row.rowGroup.setBackgroundColor(UIColor.darkGray)
            }
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}

extension UIColor {
    static let defaultGray = UIColor(red: 242, green: 244, blue: 255, alpha: 0.14)
}
