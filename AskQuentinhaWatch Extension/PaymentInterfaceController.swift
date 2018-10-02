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

    @IBOutlet var cashButton: WKInterfaceGroup!
    @IBOutlet var creditCardButton: WKInterfaceGroup!

    var payWithCash : Bool? = nil

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
                cashButton.setBackgroundColor(UIColor.clear)
            } else {
                payWithCash = true
                cashButton.setBackgroundColor(UIColor.darkGray)
                creditCardButton.setBackgroundColor(UIColor.clear)
            }
        } else {
            payWithCash = true
            cashButton.setBackgroundColor(UIColor.darkGray)
        }
    }

    @IBAction func applePayAction() {
        if let p = payWithCash {
            if (!p) {
                payWithCash = nil
                creditCardButton.setBackgroundColor(UIColor.clear)
            } else {
                payWithCash = false
                creditCardButton.setBackgroundColor(UIColor.darkGray)
                cashButton.setBackgroundColor(UIColor.clear)
            }
        } else {
            payWithCash = false
            creditCardButton.setBackgroundColor(UIColor.darkGray)
        }
    }

}

extension PaymentInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session default activate (\(activationState))")
    }
    
}
