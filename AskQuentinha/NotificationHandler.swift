//
//  NotificationHandler.swift
//  AskQuentinha
//
//  Created by IFCE on 02/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationHandler: NSObject {
	
	static let shared = NotificationHandler()
	
	private var notificationCenter = UNUserNotificationCenter.current()
	
	private override init() {}
	
	/// Requests authorization for notifications
	func requestAuthorization() {
		let center = UNUserNotificationCenter.current()
		let options: UNAuthorizationOptions = [.alert, .sound]
		
		center.requestAuthorization(options: options) { (granted, error) in
			print("granted: \(granted)")
		}
		
		center.delegate = self
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

// - MARK: UNUserNotificationCenterDelegate Implementation.
extension NotificationHandler: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler([.alert, .sound])
	}
}
