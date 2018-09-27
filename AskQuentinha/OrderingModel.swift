//
//  OrderingModel.swift
//  AskQuentinha
//
//  Created by IFCE on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import UserNotifications

class OrderingModel: NSObject {
	
	private var notificationCenter = UNUserNotificationCenter.current()
	
	/// Make an order.
	func makeOrder() {
		self.createLocalNotification(
			title: "Iniciado o Preparo",
			body: "Daqui a 2 mins",
			category: "firstNotification",
			trigger: UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false))
	}
	
	
	/// Creates a local notification.
	///
	/// - Parameters:
	///   - title: title of notification
	///   - body: message of notification
	///   - category: category to use in watch notification interface
	///   - trigger: trigger, must inherit from UNNotificationTrigger
	func createLocalNotification(title: String, body: String, category: String, trigger: UNNotificationTrigger) {
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
