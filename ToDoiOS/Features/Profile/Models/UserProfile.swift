import Foundation
import SwiftData

@Model
final class UserProfile {
    var id: UUID
    var name: String
    var totalPoints: Int
    var level: Int
    var tasksCompleted: Int
    var currentStreak: Int
    var longestStreak: Int
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String = "User",
        totalPoints: Int = 0,
        level: Int = 1,
        tasksCompleted: Int = 0,
        currentStreak: Int = 0,
        longestStreak: Int = 0,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.totalPoints = totalPoints
        self.level = level
        self.tasksCompleted = tasksCompleted
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.createdAt = createdAt
    }
}
