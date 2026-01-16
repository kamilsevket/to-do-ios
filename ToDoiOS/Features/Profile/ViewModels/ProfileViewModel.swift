import Foundation
import Observation

@Observable
class ProfileViewModel {

    func getCompletionRate(todos: [TodoItem]) -> Double {
        guard !todos.isEmpty else { return 0 }
        let completedCount = todos.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(todos.count)
    }
}
