//
//  ExpenseListView.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation
import SwiftUI

struct ExpenseListView: View {
    
    @StateObject private var vm: ExpenseViewModel
    
    init(vm: ExpenseViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        
        NavigationStack {
            Group {
                switch vm.state {
                case .idle, .loading:
                    ProgressView("Loading...")
                case .error(let message):
                    Text(message)
                        .foregroundColor(.red)
                case .empty:
                    Text("No expenses found")
                        .foregroundColor(.secondary)
                case .loaded(let expenses):
                    List(expenses) { expense in
                        ExpenseRowView(expense: expense)
                    }
                    .refreshable {
                        await vm.refresh()
                    }
                }
            }
            .navigationTitle("Expenses")
            .task {
                await vm.loadExpenses()
            }
        }
    }
}
