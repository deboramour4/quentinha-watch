//
//  InterfaceController.swift
//  AskQuentinhaWatch Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var emojiLabel: WKInterfaceLabel!
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
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
                                                 duration: 60,
                                                 repeatCount: 1)
    }

}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Ativa")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        emojiLabel.setText(message["status"] as? String)
    }
    
}
