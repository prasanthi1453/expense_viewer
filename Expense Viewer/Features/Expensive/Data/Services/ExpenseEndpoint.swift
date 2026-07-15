//
//  ExpenseEndpoint.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

enum ExpenseEndpoint: Endpoint {
    
    case fetchExpenses
    
    var baseURL: URL {
        URL(string: "https://www.jsonkeeper.com")!
    }
    
    var path: String {
        switch self {
        case .fetchExpenses:
            return "/b/DYZJF"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchExpenses:
            return .GET
        }
    }
}
