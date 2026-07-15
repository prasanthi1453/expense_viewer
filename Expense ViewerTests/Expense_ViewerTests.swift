//
//  Expense_ViewerTests.swift
//  Expense ViewerTests
//
//  Created by Prasanthi Somepalli on 15/07/26.
//

import Foundation
import Testing
@testable import Expense_Viewer

struct Expense_ViewerTests {

    @Test func mapperCreatesExpensesFromDummyJSON() {
        let mapper = ExpenseDataMapperAdapter()

        let expenses = mapper.map(data: Self.dummyExpenseData)

        #expect(expenses.count == 2)
        #expect(expenses[0].id == "1")
        #expect(expenses[0].title == "Flight to SF")
        #expect(expenses[0].amount == 230.50)
        #expect(expenses[1].id == "2")
        #expect(expenses[1].title == "Hotel")
        #expect(expenses[1].amount == 550.00)
    }

    @MainActor
    @Test func loadExpensesSetsLoadedStateSortedByNewestDate() async {
        let viewModel = ExpenseViewModel(
            service: MockExpenseService(expenses: Self.dummyExpenses)
        )

        await viewModel.loadExpenses()

        guard case .loaded(let expenses) = viewModel.state else {
            Issue.record("Expected loaded state")
            return
        }

        #expect(expenses.map(\.id) == ["2", "1"])
        #expect(expenses.first?.title == "Hotel")
    }

    @MainActor
    @Test func loadExpensesSetsEmptyStateWhenServiceReturnsNoExpenses() async {
        let viewModel = ExpenseViewModel(
            service: MockExpenseService(expenses: [])
        )

        await viewModel.loadExpenses()

        guard case .empty = viewModel.state else {
            Issue.record("Expected empty state")
            return
        }
    }

    @MainActor
    @Test func loadExpensesSetsErrorStateWhenServiceThrows() async {
        let viewModel = ExpenseViewModel(
            service: MockExpenseService(error: APIError.networkError)
        )

        await viewModel.loadExpenses()

        guard case .error(let message) = viewModel.state else {
            Issue.record("Expected error state")
            return
        }

        #expect(message == "Network error occurred")
    }

    private static let dummyExpenseData = """
    [
      {
        "id": "1",
        "title": "Flight to SF",
        "amount": 230.50,
        "date": "2021-07-03T01:50:00+01:00"
      },
      {
        "id": "2",
        "title": "Hotel",
        "amount": 550.00,
        "date": "2021-08-03T01:50:00+01:00"
      }
    ]
    """.data(using: .utf8)!

    private static let dummyExpenses = ExpenseDataMapperAdapter().map(data: dummyExpenseData)
}

private final class MockExpenseService: ExpenseServiceProtocol {
    private let expenses: [Expense]
    private let error: Error?

    init(expenses: [Expense] = [], error: Error? = nil) {
        self.expenses = expenses
        self.error = error
    }

    func fetchExpenses() async throws -> [Expense] {
        if let error {
            throw error
        }

        return expenses
    }
}
