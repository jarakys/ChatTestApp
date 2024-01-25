//
//  MessageModel.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

struct MessageModel: MessageableContainer {
    var messageId: String
    var userId: String
    var message: MessageType
    var userName: String
    var userImage: String
    var date: Date
    var status: MessageStatus
}
