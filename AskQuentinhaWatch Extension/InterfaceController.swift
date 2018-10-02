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
    
    var orderInProgress = false

    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var emojiLabel: WKInterfaceLabel!
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet var newOrderButton: WKInterfaceButton!

    var contTimer = 0

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        toggleMenuButton(noOrder: true)
    }
    
    override func willActivate() {
        super.willActivate()

        if WCSession.isSupported() {
            WCSession.default.delegate = self
            if !(WCSession.default.activationState == WCSessionActivationState.activated) {
                WCSession.default.activate()
            }
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func didAppear() {
    }

    @IBAction func newOrderButtonAction() {
        if orderInProgress {
            cancelOrderAction()
        } else {
            newOrderAction()
        }
    }

    @objc func newOrderAction() {
        Order.current = Order()
        presentController(withNames: ["MealInterfaceController", "PaymentInterfaceController"], contexts: nil)
    }

    @objc func cancelOrderAction() {
        presentAlert(withTitle: "Cancelar Pedido", message: "Confirma cancelamento?", preferredStyle: .sideBySideButtonsAlert, actions: [
            WKAlertAction(title: "Sim", style: .cancel, handler: {
                print("order cancel")
                self.cancelCurrentOrder()
            }),
            WKAlertAction(title: "Não", style: .default, handler: {
                print("order not canceled")
            })
        ])
    }
    
    func cancelCurrentOrder() {
        WCSession.default.sendMessage(["action": "cancelOrder"], replyHandler: nil, errorHandler: nil)
        resetInterface()
    }
    
    func resetInterface() {
        titleLabel.setText("Faça seu pedido")
        emojiLabel.setText("😃")
        self.toggleMenuButton(noOrder: true)
        backgroundGroup.setBackgroundImageNamed("Progress")
        contTimer = 0
    }

    /*It Changes the content and function of the menu button
      When it has no orders, menu shows "Novo Pedido"
      When an order is being made, menu shows "Cancelar Pedido"*/
    func toggleMenuButton(noOrder: Bool) {
        if noOrder {
            orderInProgress = false
            newOrderButton.setTitle("Pedir")
            self.clearAllMenuItems()
            self.addMenuItem(with: .add, title: "Novo Pedido", action: #selector(InterfaceController.newOrderAction))
        } else {
            orderInProgress = true
            newOrderButton.setTitle("Cancelar")
            self.clearAllMenuItems()
            self.addMenuItem(with: .decline , title: "Cancelar Pedido", action: #selector(InterfaceController.cancelOrderAction))
        }
    }

}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Ativa")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let _ = message["noOrder"] as? String {
            DispatchQueue.main.async {
                self.toggleMenuButton(noOrder: true)
            }
            contTimer = 0

        } else {
            titleLabel.setText(message["title"] as? String)
            emojiLabel.setText(message["emoji"] as? String)

            backgroundGroup.setBackgroundImageNamed("Progress")
            backgroundGroup.startAnimatingWithImages(in: NSRange(location: contTimer, length: 19),
                                                         duration: 1,
                                                         repeatCount: 1)
            contTimer = contTimer+20
            if !orderInProgress {
                DispatchQueue.main.async {
                    self.toggleMenuButton(noOrder: false)
                }
            }
        }
    }
    
}
