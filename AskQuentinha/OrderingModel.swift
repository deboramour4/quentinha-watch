//
//  OrderingModel.swift
//  AskQuentinha
//
//  Created by IFCE on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import UserNotifications

enum OrderStatus: String {
	case confirmed = "😉"
	case preparing = "👩‍🍳"
	case outForDelivery = "🚗"
	case ready = "🤩"
}

class OrderingModel: NSObject {
	
	private var notificationCenter = UNUserNotificationCenter.current()
	
	/// Make an order.
	func makeOrder() {
		self.createLocalNotification(
			title: "Pedido confirmado pelo restaurante",
			body: "Iniciaremos logo o preparo",
			category: "InitialNotification",
			trigger: UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false))
		
		self.createLocalNotification(
			title: "Iniciado o preparo do pedido",
			body: "Previsão de pronto daqui a 2 mins",
			category: "FirstNotification",
			trigger: UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false))
		
		self.createLocalNotification(
			title: "Saiu para entrega",
			body: "Previsão de chegada daqui a 1 min",
			category: "SecondNotification",
			trigger: UNTimeIntervalNotificationTrigger(timeInterval: 9, repeats: false))
		
		self.createLocalNotification(
			title: "Tamo aqui",
			body: "Pode vir buscar aqui na entrada",
			category: "ArrivedNotification",
			trigger: UNTimeIntervalNotificationTrigger(timeInterval: 12, repeats: false))
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
