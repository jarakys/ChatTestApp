//
//  ChatService.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation
import Combine

protocol ChatService<T> {
    associatedtype T
    var messageSender: PassthroughSubject<T, Never> { get set }
    func send(message: T, chatId: String) async throws
    func fetchItems(paginator: Paginator) async throws -> [T]
}
