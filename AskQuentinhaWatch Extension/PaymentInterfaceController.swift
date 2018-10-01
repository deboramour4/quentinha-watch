//
//  PaymentInterfaceController.swift
//  AskQuentinhaWatch Extension
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class PaymentInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func didFinishedOrder() {
        let currentOrder = completeOrder()
        sendOrder(order: currentOrder)
    }
    
    func completeOrder() -> [String : Any] {
        let order: [String : Any] = ["cost": 10.0, "paymentType": "cash"]
        return order
    }
    
    func sendOrder(order: [String : Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(order, replyHandler: nil, errorHandler: nil)
        }
    }

}

extension PaymentInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session default activate (\(activationState))")
    }
    
}
