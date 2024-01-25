//
//  Bindable.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation
import Combine

protocol Bindable {
    var cancellable: Set<AnyCancellable> { get set }
    func bind()
}
