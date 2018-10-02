//
//  OrderingModel.swift
//  AskQuentinha
//
//  Created by IFCE on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import UserNotifications

protocol OrderingModelDelegate {
	func send(message: [String: Any])
}

class OrderingModel: NSObject {
	
	var delegate: OrderingModelDelegate?
	
	private (set) var currentStatus = OrderStatus.noOrder
	
	private var timer: DispatchSourceTimer?
	
	private var notificationHandler = NotificationHandler.shared
	
	
	/// Set up and start the entire order preparation process.
	func makeOrderWithTimer() {
		let queue = DispatchQueue(label: "OrderTimer")
		
		self.timer?.cancel()
		self.timer = DispatchSource.makeTimerSource(queue: queue)
		self.timer?.schedule(deadline: .now(), repeating: .seconds(2), leeway: .seconds(1))
		self.timer?.setEventHandler(handler: {
			print("Passar status")
			
			self.currentStatus = self.currentStatus.next
			let statusInfo = self.currentStatus.info
			
			if self.currentStatus == .noOrder {
				self.stopTimer()
				
				self.delegate?.send(message: ["NoOrder": "true"])
			} else {
				self.notificationHandler.createLocalNotification(
					title: statusInfo.title,
					body: statusInfo.body,
					category: statusInfo.category,
					trigger: UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false))
				
                let message = [
                	"title": statusInfo.title,
                	"emoji": statusInfo.emoji
                ]
				self.delegate?.send(message: message)
			}
		})
		self.timer?.resume()
	}
	
	private func stopTimer() {
		self.timer?.cancel()
		self.timer = nil
	}
    
    func cancelOrder() {
        self.stopTimer()
        self.currentStatus = .noOrder
    }

	/// Adds a notification to remind the user to place the order at the specified time.
	func configureCalendarReminder() {
		var date = DateComponents()
		date.hour = 9
		date.minute = 40
		date.timeZone = TimeZone.current
		
		let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
		
		self.notificationHandler.createLocalNotification(
			title: "Já pediu sua quentinha de hoje?",
			body: "Não deixe de pedir",
			category: "ReminderNotification",
			trigger: trigger)
	}
	
}
