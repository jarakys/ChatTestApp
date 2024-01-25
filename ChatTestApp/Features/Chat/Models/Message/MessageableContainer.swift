//
//  MessageableContainer.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

protocol MessageableContainer {
    var messageId: String { get }
    var userId: String { get }
    var userName: String { get }
    var userImage: String { get }
    var message: MessageType { get }
    var date: Date { get }
    var status: MessageStatus { get }
}
