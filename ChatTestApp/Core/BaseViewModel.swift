//
//  BaseViewModel.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation
import Combine

class BaseViewModel<TEvent, TError> {
    let eventSender = PassthroughSubject<TEvent, Never>()
    let errorSender = PassthroughSubject<TError, Never>()
}
