import Foundation
import SwiftData
import Observation

@Observable
class TodoViewModel {

    func completeTodo(_ todo: TodoItem, context: ModelContext) {
        guard !todo.isCompleted else { return }

        todo.complete()

        // Update user profile
        let descriptor = FetchDescriptor<UserProfile>()
        if let profiles = try? context.fetch(descriptor), let profile = profiles.first {
            profile.addPoints(todo.pointsAwarded)
        }

        // Check achievements
        checkAchievements(context: context)
    }

    private func checkAchievements(context: ModelContext) {
        let profileDescriptor = FetchDescriptor<UserProfile>()
        let achievementDescriptor = FetchDescriptor<Achievement>()

        guard let profiles = try? context.fetch(profileDescriptor),
              let profile = profiles.first,
              let achievements = try? context.fetch(achievementDescriptor) else {
            return
        }

        for achievement in achievements {
            switch achievement.type {
            case .firstTask, .tenTasks, .fiftyTasks, .hundredTasks:
                achievement.updateProgress(profile.tasksCompleted)
            case .weekStreak, .monthStreak:
                achievement.updateProgress(profile.currentStreak)
            case .levelFive, .levelTen:
                achievement.updateProgress(profile.level)
            }
        }
    }
}
