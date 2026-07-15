//
//  APIError.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

enum APIError: Error, LocalizedError {
    
    case invalidURL
    case networkError
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError:
            return "Network error occurred"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error (\(code))"
        case .unknown:
            return "Something went wrong"
        }
    }
}
