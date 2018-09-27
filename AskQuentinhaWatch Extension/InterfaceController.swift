//
//  InterfaceController.swift
//  AskQuentinhaWatch Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func didAppear() {
        backgroundGroup.setBackgroundImageNamed("Progress")
        backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 99),
                                                 duration: 600,
                                                 repeatCount: 1)
    }

}
