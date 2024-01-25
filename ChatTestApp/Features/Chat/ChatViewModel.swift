//
//  ChatViewModel.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

import Combine

final class ChatViewModel: BaseViewModel<ChatEvent, ChatError>, Bindable {
    @Published var text: String = ""
    
    var cancellable = Set<AnyCancellable>()
    
    func bind() {
        
    }
    
    func sendDidTap() {
        guard text.isNotEmpty else {
            eventSender.send(.textFieldDrgging)
            return
        }
        sendText()
    }
    
    private func sendText() {
        eventSender.send(.loading)
        
        Task.detached(operation: {
            
        })
        
        eventSender.send(.loadingEnd)
    }
}
