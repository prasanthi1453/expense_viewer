//
//  URLRequestBuilder.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

protocol URLRequestBuilder {
    func build(from endpoint: Endpoint) throws -> URLRequest
}

final class DefaultURLRequestBuilder: URLRequestBuilder {
    
    func build(from endpoint: Endpoint) throws -> URLRequest {
        
        guard var components = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else {
            throw APIError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        
        return request
    }
}