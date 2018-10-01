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

    @IBOutlet var cashButton: WKInterfaceButton!
    @IBOutlet var creditCardButton: WKInterfaceButton!

    var payWithCash : Bool? = false

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
        WCSession.default.sendMessage(order, replyHandler: nil, errorHandler: nil)
    }
    @IBAction func cashAction() {
        if let p = payWithCash {
            if (p) {
                payWithCash = nil
                cashButton.setBackgroundColor(UIColor.defaultGray)
            } else {
                payWithCash = true
                cashButton.setBackgroundColor(UIColor.gray)
                creditCardButton.setBackgroundColor(UIColor.defaultGray)
            }
        } else {
            payWithCash = true
            cashButton.setBackgroundColor(UIColor.gray)
        }
    }

    @IBAction func applePayAction() {
        if let p = payWithCash {
            if (!p) {
                payWithCash = nil
                creditCardButton.setBackgroundColor(UIColor.defaultGray)
            } else {
                payWithCash = false
                creditCardButton.setBackgroundColor(UIColor.gray)
                cashButton.setBackgroundColor(UIColor.defaultGray)
            }
        } else {
            payWithCash = false
            creditCardButton.setBackgroundColor(UIColor.gray)
        }
    }

}

extension PaymentInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session default activate (\(activationState))")
    }
    
}
