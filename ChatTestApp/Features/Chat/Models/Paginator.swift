//
//  Paginator.swift
//  ChatTestApp
//
//  Created by Kyrylo Chernov on 25.01.2024.
//

import Foundation

class Paginator {
    var currentPage: Int
    let itemPerPage: Int
    
    init(currentPage: Int, itemPerPage: Int) {
        self.currentPage = currentPage
        self.itemPerPage = itemPerPage
    }
    
    func nextPage() {
        currentPage += 1
    }
    
    func previousPage() {
        currentPage -= 1
    }
    
    func resetPage() {
        currentPage = 0
    }
}
