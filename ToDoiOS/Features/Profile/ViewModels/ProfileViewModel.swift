import Foundation
import SwiftData
import Observation

@Observable
class ProfileViewModel {

    func getCompletionRate(todos: [TodoItem]) -> Double {
        guard !todos.isEmpty else { return 0 }
        let completed = todos.filter { $0.isCompleted }.count
        return Double(completed) / Double(todos.count)
    }

    func getPointsThisWeek(todos: [TodoItem]) -> Int {
        let calendar = Calendar.current
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()

        return todos
            .filter { $0.isCompleted && ($0.completedAt ?? Date.distantPast) > weekAgo }
            .reduce(0) { $0 + $1.pointsAwarded }
    }

    func getTasksCompletedByDay(todos: [TodoItem]) -> [Date: Int] {
        var result: [Date: Int] = [:]
        let calendar = Calendar.current

        for todo in todos where todo.isCompleted {
            guard let completedAt = todo.completedAt else { continue }
            let day = calendar.startOfDay(for: completedAt)
            result[day, default: 0] += 1
        }

        return result
    }
}
