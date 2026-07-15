//
//  ExpenseRowView.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation
import SwiftUI

struct ExpenseRowView: View {
    
    let expense: Expense
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(expense.title)
                .font(.headline)
            
            Text(expense.amount, format: .currency(code: "INR"))
                .font(.subheadline)
            
            Text(expense.date.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
