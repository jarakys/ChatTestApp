//
//  MessageableContainer.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

protocol MessageableContainer {
    var userId: String { get }
    var userName: String { get }
    var userImage: String { get }
    var message: MessageType { get }
}
