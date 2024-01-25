//
//  ChatService.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation
import Combine

protocol ChatService {
    associatedtype T
    var messageSender: CurrentValueSubject<T, Never> { get set }
    func sendText(text: String, chatId: String) throws
}
