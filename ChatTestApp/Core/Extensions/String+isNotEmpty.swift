//
//  String+isNotEmpty.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        !replacingOccurrences(of: " ", with: "").isEmpty
    }
}
