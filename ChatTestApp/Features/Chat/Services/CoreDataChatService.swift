//
//  CoreDataChatService.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation
import Combine

final class MockChatService: ChatService {
    var messageSender = PassthroughSubject<MessageModel, Never>()
    
    private var items = [MessageModel]()
    
    init() {
        for i in 1...40 {
            let messageId = "Message\(i)"
            let userId = "User\(i)"
            let userName = "User Name \(i)"
            let userImage = "UserImage\(i).png"
            let date = Date()
            
            let messageModel = MessageModel(messageId: messageId,
                                            userId: userId,
                                            message: .text(model: MessageTextModel(text: "Text \(i)")),
                                            userName: userName,
                                            userImage: userImage,
                                            date: date,
                                            status: .success)
            
            // Add the created object to the array
            items.append(messageModel)
        }
    }
    
    func send(message: MessageModel, chatId: String) async throws {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [unowned self] in
            items.append(MessageModel(messageId: message.messageId, userId: message.userId, message: message.message, userName: message.userName, userImage: message.userImage, date: message.date, status: .success))
        })
    }
    
    func fetchItems(paginator: Paginator) async throws -> [MessageModel] {
        let itemsForSkip = paginator.currentPage * paginator.itemPerPage
        let itemsForReturn = Array(items.dropLast(itemsForSkip).prefix(paginator.itemPerPage))
        
        return itemsForReturn
    }
}
