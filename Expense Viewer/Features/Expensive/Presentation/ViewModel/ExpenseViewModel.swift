//
//  ExpenseListState.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation
import Combine

enum ExpenseListState {
    case idle
    case loading
    case loaded([Expense])
    case empty
    case error(String)
}

@MainActor
final class ExpenseViewModel: ObservableObject {
    
    @Published private(set) var state: ExpenseListState = .idle
    
    private let service: ExpenseServiceProtocol
    private var currentTask: Task<Void, Never>?
    
    init(service: ExpenseServiceProtocol) {
        self.service = service
    }
    
    func loadExpenses() async {
        currentTask?.cancel()
        
        state = .loading
        
        currentTask = Task { [service] in
            do {
                let expenses = try await service.fetchExpenses()
                    .sorted { $0.date > $1.date }
                
                if Task.isCancelled { return }
                
                if expenses.isEmpty {
                    state = .empty
                } else {
                    state = .loaded(expenses)
                }
            } catch {
                if Task.isCancelled { return }
                state = .error(error.localizedDescription)
            }
        }
        
        await currentTask?.value
    }
    
    func refresh() async {
        await loadExpenses()
    }
    
    deinit {
        currentTask?.cancel()
    }
}