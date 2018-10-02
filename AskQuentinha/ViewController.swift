//
//  ViewController.swift
//  AskQuentinha
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
	
    var myOrders: [Order] = []
    @IBOutlet weak var ordersTableView: UITableView!
    let model = OrderingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.model.delegate = self
		
        self.ordersTableView.dataSource = self
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

	// @IBAction func startPreparing(_ sender: Any) {
	// 	 self.model.makeOrderWithTimer()
	// }
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let order = Order.transformToObject(order: message)
        self.myOrders.append(order)
        self.model.makeOrderWithTimer()
        DispatchQueue.main.async {
            self.ordersTableView.reloadData()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session default in ViewController activate with \(activationState.rawValue)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
}

extension ViewController: OrderingModelDelegate {
	func send(message: [String : Any]) {
		if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
		}
	}
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") else { return UITableViewCell() }
        let order = myOrders[indexPath.row]
        cell.textLabel?.text = "\(order.garnish ?? "") e \(order.mainMeal ?? "")"
        cell.detailTextLabel?.text = order.paymentType ?? " - "
        
        return cell
    }
    
    
}
