//
//  ChatError.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

enum ChatError: Error {
    case sendError
    case unknownError(error: Error)
}
