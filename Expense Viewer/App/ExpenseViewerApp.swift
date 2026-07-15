

import SwiftUI

@main
struct ExpenseApp: App {
    
    init() {
        NetworkReachability.shared.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            ExpenseListView(vm: ExpenseViewModel(service: ExpenseService()))
        }
    }
}
