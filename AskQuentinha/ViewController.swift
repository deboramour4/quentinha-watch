//
//  ViewController.swift
//  AskQuentinha
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
	
	let model = OrderingModel()
    var lastTime: CFAbsoluteTime = CFAbsoluteTime()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

	@IBAction func startPreparing(_ sender: Any) {
        sendMessage(status: OrderStatus.confirmed)
		self.model.makeOrder()
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendMessage(status: OrderStatus) {
        if WCSession.default.isReachable {
            
            let message = ["status": status.rawValue]
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
            
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
}

