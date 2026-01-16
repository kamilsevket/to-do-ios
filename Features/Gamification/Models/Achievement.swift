import Foundation
import SwiftData

@Model
class Achievement {
    var id: UUID
    var type: AchievementType
    var isUnlocked: Bool
    var unlockedAt: Date?
    var progress: Int

    enum AchievementType: String, Codable, CaseIterable {
        case firstTask = "First Steps"
        case tenTasks = "Getting Started"
        case fiftyTasks = "Task Master"
        case hundredTasks = "Centurion"
        case weekStreak = "Week Warrior"
        case monthStreak = "Monthly Champion"
        case levelFive = "Rising Star"
        case levelTen = "Expert"

        var title: String { rawValue }

        var description: String {
            switch self {
            case .firstTask: return "Complete your first task"
            case .tenTasks: return "Complete 10 tasks"
            case .fiftyTasks: return "Complete 50 tasks"
            case .hundredTasks: return "Complete 100 tasks"
            case .weekStreak: return "Maintain a 7-day streak"
            case .monthStreak: return "Maintain a 30-day streak"
            case .levelFive: return "Reach level 5"
            case .levelTen: return "Reach level 10"
            }
        }

        var icon: String {
            switch self {
            case .firstTask: return "star.fill"
            case .tenTasks: return "flame.fill"
            case .fiftyTasks: return "trophy.fill"
            case .hundredTasks: return "crown.fill"
            case .weekStreak: return "calendar"
            case .monthStreak: return "calendar.badge.checkmark"
            case .levelFive: return "arrow.up.circle.fill"
            case .levelTen: return "sparkles"
            }
        }

        var target: Int {
            switch self {
            case .firstTask: return 1
            case .tenTasks: return 10
            case .fiftyTasks: return 50
            case .hundredTasks: return 100
            case .weekStreak: return 7
            case .monthStreak: return 30
            case .levelFive: return 5
            case .levelTen: return 10
            }
        }
    }

    init(type: AchievementType) {
        self.id = UUID()
        self.type = type
        self.isUnlocked = false
        self.unlockedAt = nil
        self.progress = 0
    }

    func updateProgress(_ value: Int) {
        progress = value
        if progress >= type.target && !isUnlocked {
            isUnlocked = true
            unlockedAt = Date()
        }
    }
}
