//
//  ViewController.swift
//  AskQuentinha
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import WatchConnectivity
import Foundation

class ViewController: UIViewController {
	
    var myOrders: [Order] = []
    @IBOutlet weak var ordersTableView: UITableView!
    let model = OrderingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.model.delegate = self
		self.model.configureCalendarReminder()
		
        self.ordersTableView.dataSource = self
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let action = message["action"] as? String {
            if action == "cancelOrder" {
                self.model.cancelOrder()
            }
        }
        else {
            let order = Order.transformToObject(order: message)
            self.myOrders.append(order)
            self.model.makeOrderWithTimer(order)
            DispatchQueue.main.async {
                self.ordersTableView.reloadData()
            }
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
    
    func didChangedOrderStatus(_ order: Order) {
        for o in myOrders where o == order {
            o.status = order.status
        }
        DispatchQueue.main.async {
            self.ordersTableView.reloadData()
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
        
        let description = "\(order.garnish ?? "") e \(order.mainMeal ?? "")"
        let detail = order.paymentType ?? " - "
        cell.textLabel?.text = description
        cell.detailTextLabel?.text = detail
        
        if order.status == .cancelled {
            let attributedDescription: NSMutableAttributedString =  NSMutableAttributedString(string: description)
            attributedDescription.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedDescription.length))
            
            let attributedDetail: NSMutableAttributedString =  NSMutableAttributedString(string: detail)
            attributedDetail.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedDetail.length))
            
            cell.textLabel?.attributedText = attributedDescription
            cell.detailTextLabel?.attributedText = attributedDetail
        }
        
        return cell
    }
    
    
}
