//
//  BaseViewModel.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation
import Combine

class BaseViewModel<TEvent, TError>: Bindable {
    let eventSender = PassthroughSubject<TEvent, Never>()
    let errorSender = PassthroughSubject<TError, Never>()
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    func bind() {
        fatalError("Not implemented")
    }
}
