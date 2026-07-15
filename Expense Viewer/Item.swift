//
//  Item.swift
//  Expense Viewer
//
//  Created by Prasanthi Somepalli on 15/07/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
