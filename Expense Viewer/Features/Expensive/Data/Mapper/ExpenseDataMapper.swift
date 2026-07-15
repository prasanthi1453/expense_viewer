//
//  ExpenseDataMapper.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//


import Foundation

protocol ExpenseDataMapper {
    func map(data: Data) -> [Expense]
}


final class ExpenseDataMapperAdapter: ExpenseDataMapper {

    private var transformer: ExpenseTransformer? = ExpenseTransformer()

    func map(data: Data) -> [Expense] {
        let arr = transformer?.transform(data) as? [[String: Any]] ?? []
        return arr.compactMap { Expense(dict: $0) }
    }

    deinit {
        transformer = nil
    }
}
