//
//  ExpenseServiceProtocol.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

protocol ExpenseServiceProtocol {
    func fetchExpenses() async throws -> [Expense]
}

final class ExpenseService: ExpenseServiceProtocol {
    
    private let apiClient: APIClientProtocol
    private let mapper: ExpenseDataMapper
    
    init(
        apiClient: APIClientProtocol = APIClient(),
        mapper: ExpenseDataMapper = ExpenseDataMapperAdapter()
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
    }
    
    func fetchExpenses() async throws -> [Expense] {
        
        do {
            let data = try await apiClient.request(from: ExpenseEndpoint.fetchExpenses)
            let expenses = mapper.map(data: data)
            
            return expenses
            
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.unknown
        }
    }
}