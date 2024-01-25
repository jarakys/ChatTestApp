//
//  ChatViewModel.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

import Combine

final class ChatViewModel: BaseViewModel<ChatEvent, ChatError> {
    @Published var text: String = ""
    @Published var messages = [MessageModel]()
    
    var messagesCount: Int {
        messages.count
    }
    
    var messagesMiddleCount: Int {
        messagesCount / 2
    }
    
    private let service: any ChatService<MessageModel>
    
    private lazy var paginator: Paginator = {
        Paginator(currentPage: 0, itemPerPage: 15)
    }()
    
    init(service: any ChatService<MessageModel>) {
        self.service = service
        super.init()
    }
    
    override func bind() {
        // Handle first load messages or new messages
        service.messageSender.receive(on: RunLoop.main).sink(receiveValue: { [weak self] messagesModel in
            guard let self else { return }
            
            // Check for peing and replace
            
            guard self.paginator.currentPage == 0 else {
                // show notification about message etc
                return
            }
            
            if let index = self.pendingIndexIfExist(for: messagesModel) {
                self.messages[index] = messagesModel
            } else {
                self.messages.append(messagesModel)
            }
            
            //TODO: Recieve items
        }).store(in: &cancellable)
    }
    
    func userScroll(to: ScollDirection, with unvisibleItem: MessageModel) {
        guard let messageModelIndex = messages.lastIndex(where: { $0.messageId == unvisibleItem.messageId }) else {
            print("Message doesn't exist ???")
            return
        }
        
        switch to {
        case .top:
            guard messageModelIndex >= messagesCount - messagesMiddleCount else { return }
            fetchItemsIfNeeded(for: to)
            
        case .bottom:
            guard messageModelIndex - messagesMiddleCount >= messagesCount else { return }
            fetchItemsIfNeeded(for: to)
            
        }
    }
    
    func sendDidTap() {
        guard text.isNotEmpty else {
            eventSender.send(.textFieldDrgging)
            return
        }
        // Logic for handle images, text, videos, create Model for each. In this case only text type
        
        sendMessage(messageType: .text(model: MessageTextModel(text: text)))
    }
    
    private func pendingIndexIfExist(for message: MessageModel) -> Int? {
        messages.firstIndex(where: { $0.messageId == message.messageId })
    }
    
    private func fetchItemsIfNeeded(for: ScollDirection) {
        switch `for` {
        case .top:
            paginator.previousPage()
            
        case .bottom:
            paginator.nextPage()
        }
        
        Task.detached(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            
            do {
                let messagesModel = try await self.service.fetchItems(paginator: self.paginator)
                let tmpMessages = self.messages
                let messagesMiddleCount = self.messagesMiddleCount
                
                await MainActor.run(body: {
                    switch `for` {
                    case .top:
                        let newMessages = [messagesModel, tmpMessages.dropLast(messagesMiddleCount)].flatMap({ $0 })
                        self.messages.insert(contentsOf: newMessages, at: 0)
                        
                    case .bottom:
                        let slicesMessages = Array(tmpMessages.dropFirst(messagesMiddleCount))
                        let newMessages = [messagesModel, slicesMessages].flatMap({ $0 })
                        self.messages.append(contentsOf: newMessages)
                    }
                })
            } catch {
                self.errorSender.send(.unknownError(error: error))
            }
        }
    }
    
    private func sendMessage(messageType: MessageType) {
        //Harcoded UserID = 1
        let message = MessageModel(messageId: UUID().uuidString, userId: "1", message: messageType, userName: "Kirill", userImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.nationalgeographic.com%2Fanimals%2Fmammals%2Ffacts%2Fdomestic-cat&psig=AOvVaw3Yx0XWtPFhlcH0SXkU5AF-&ust=1706293230066000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMiArOCT-YMDFQAAAAAdAAAAABAE", date: .now, status: .pending)
        messages.append(message)
        
        Task.detached(operation: { [weak self] in
            guard let self else { return }
            do {
                try await self.service.send(message: message, chatId: "1")
            } catch {
                self.errorSender.send(.unknownError(error: error))
            }
        })
    }
}
