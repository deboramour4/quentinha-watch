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
	
	private var notificationCenter = UNUserNotificationCenter.current()
	private (set) var currentStatus = OrderStatus.noOrder
	
	private var timer: DispatchSourceTimer?
	
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
			} else {
				self.createLocalNotification(
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
	
	/// Creates a local notification.
	///
	/// - Parameters:
	///   - title: title of notification
	///   - body: message of notification
	///   - category: category to use in watch notification interface
	///   - trigger: trigger, must inherit from UNNotificationTrigger
	private func createLocalNotification(title: String, body: String, category: String, trigger: UNNotificationTrigger) {
		self.notificationCenter.getNotificationSettings { (settings) in
			guard settings.authorizationStatus == .authorized else { return }
			
			let content = UNMutableNotificationContent()
			content.title = title
			content.body = body
			content.categoryIdentifier = category
			
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			
			UNUserNotificationCenter.current().add(request) { error in
				if (error != nil) { print(error!) }
			}
		}
	}
}
