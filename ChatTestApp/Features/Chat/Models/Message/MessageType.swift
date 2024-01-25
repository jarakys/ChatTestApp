//
//  MessageType.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

enum MessageType {
    case text(model: MessageTextModel)
    case textWithImage
}
