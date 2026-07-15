//
//  Expense.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

struct Expense: Identifiable {
    let id: String
    let title: String
    let amount: Double
    let date: Date
}

extension Expense {
    init?(dict: [String: Any]) {
        guard
            let id = dict["id"] as? String,
            let title = dict["title"] as? String,
            let amount = dict["amount"] as? Double,
            let date = dict["date"] as? Date
        else { return nil }
        
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
    }
}