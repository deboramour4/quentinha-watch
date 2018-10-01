//
//  MealRowController.swift
//  AskQuentinhaWatch Extension
//
//  Created by Ada 2018 on 28/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

class GarnishRowController: NSObject {

    @IBOutlet var garnishLabel: WKInterfaceLabel!
    @IBOutlet var rowGroup: WKInterfaceGroup!

    var garnish: String? {
        didSet {
            garnishLabel.setText(garnish)
        }
    }



}
