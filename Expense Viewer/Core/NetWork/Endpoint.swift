//
//  Endpoint.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

protocol Endpoint {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension Endpoint {
    
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var body: Data? {
        nil
    }
}
