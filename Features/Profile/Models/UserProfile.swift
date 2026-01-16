import Foundation
import SwiftData

@Model
class UserProfile {
    var id: UUID
    var totalPoints: Int
    var level: Int
    var tasksCompleted: Int
    var currentStreak: Int
    var longestStreak: Int
    var lastCompletionDate: Date?
    var createdAt: Date

    init() {
        self.id = UUID()
        self.totalPoints = 0
        self.level = 1
        self.tasksCompleted = 0
        self.currentStreak = 0
        self.longestStreak = 0
        self.lastCompletionDate = nil
        self.createdAt = Date()
    }

    var pointsForNextLevel: Int {
        level * 100
    }

    var progressToNextLevel: Double {
        let pointsInCurrentLevel = totalPoints - ((level - 1) * 100)
        return Double(pointsInCurrentLevel) / Double(pointsForNextLevel)
    }

    func addPoints(_ points: Int) {
        totalPoints += points
        tasksCompleted += 1
        updateStreak()
        checkLevelUp()
    }

    private func updateStreak() {
        let calendar = Calendar.current
        if let lastDate = lastCompletionDate {
            if calendar.isDateInYesterday(lastDate) {
                currentStreak += 1
            } else if !calendar.isDateInToday(lastDate) {
                currentStreak = 1
            }
        } else {
            currentStreak = 1
        }
        longestStreak = max(longestStreak, currentStreak)
        lastCompletionDate = Date()
    }

    private func checkLevelUp() {
        while totalPoints >= level * 100 {
            level += 1
        }
    }
}
