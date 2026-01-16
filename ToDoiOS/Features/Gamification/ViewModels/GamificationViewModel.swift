import Foundation
import SwiftData
import Observation

@Observable
class GamificationViewModel {
    var showLevelUpCelebration = false
    var newLevel: Int = 0

    func initializeAchievements(context: ModelContext) {
        let descriptor = FetchDescriptor<Achievement>()
        guard let existingAchievements = try? context.fetch(descriptor),
              existingAchievements.isEmpty else {
            return
        }

        for type in Achievement.AchievementType.allCases {
            let achievement = Achievement(type: type)
            context.insert(achievement)
        }
    }

    func initializeProfile(context: ModelContext) {
        let descriptor = FetchDescriptor<UserProfile>()
        guard let existingProfiles = try? context.fetch(descriptor),
              existingProfiles.isEmpty else {
            return
        }

        let profile = UserProfile()
        context.insert(profile)
    }

    func checkForLevelUp(previousLevel: Int, currentLevel: Int) {
        if currentLevel > previousLevel {
            newLevel = currentLevel
            showLevelUpCelebration = true
        }
    }
}
