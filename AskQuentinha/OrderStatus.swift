//
//  OrderStatus.swift
//  AskQuentinha
//
//  Created by IFCE on 01/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

enum OrderStatus {
	case noOrder
	case processed
	case confirmed
	case preparing
	case outForDelivery
	case ready
	
	var next: OrderStatus {
		switch self {
		case .noOrder:
			return .processed
		case .processed:
			return .confirmed
		case .confirmed:
			return .preparing
		case .preparing:
			return .outForDelivery
		case .outForDelivery:
			return .ready
		case .ready:
			return .noOrder
		}
	}
	
	var info: (title: String, body: String, category: String, emoji: String) {
		switch self {
		case .noOrder:
			return ("Nenhum pedido no momento", "", "", "")
		case .processed:
			return ("Pedido processado", "Aguardando confirmação do restaurante", "ProcessedNotification", "😉")
		case .confirmed:
			return ("Pedido confirmado pelo restaurante", "Iniciaremos logo o preparo", "ConfirmedNotification", "✅")
		case .preparing:
			return ("Iniciado o preparo do pedido", "Previsão de pronto daqui a 2 mins", "PreparingNotification", "👨‍🍳")
		case .outForDelivery:
			return ("Saiu para entrega", "Previsão de chegada daqui a 1 min", "OutForDeliveryNotification", "🚗")
		case .ready:
			return ("Tamo aqui", "Pode vir buscar aqui na entrada", "ReadyNotification", "🍲")
		}
	}
}
