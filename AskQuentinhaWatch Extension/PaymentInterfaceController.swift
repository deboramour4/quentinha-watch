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

    var payWithCash : Bool? = nil {
        didSet {
            if let withCash = payWithCash {
                Order.current.paymentType = withCash ? "Dinheiro" : "Cartão"
            } else {
                Order.current.paymentType = "Dinheiro"
            }
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            if !(WCSession.default.activationState == WCSessionActivationState.activated) {
                WCSession.default.activate()
            }
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // Called when Finish button is tapped
    @IBAction func didFinishedOrder() {
        if let currentOrder = completeOrder() {
            sendOrder(order: currentOrder)
        }
        else {
            presentAlert(withTitle: "Pedido incompleto", message: "Preencha o pedido para continuar", preferredStyle: .alert, actions: [
                WKAlertAction(title: "OK", style: .cancel, handler: { })
            ])
        }
    }
    
    // Verify if current Order is valid and return the dictionary
    func completeOrder() -> [String : Any]? {
        let order = Order.current
        if !order.isValid {
            return nil
        }
        let result: [String : Any] = order.transformToDict()
        return result
    }
    
    // Verify if default WCSession is reachable and send an Order as message
    func sendOrder(order: [String : Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(order, replyHandler: nil, errorHandler: nil)
            dismiss()
        }
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
