import Foundation
import SwiftData

@Model
final class Achievement {
    var id: UUID
    var title: String
    var achievementDescription: String
    var iconName: String
    var isUnlocked: Bool
    var unlockedAt: Date?
    var requiredPoints: Int

    init(
        id: UUID = UUID(),
        title: String,
        achievementDescription: String,
        iconName: String,
        isUnlocked: Bool = false,
        unlockedAt: Date? = nil,
        requiredPoints: Int = 0
    ) {
        self.id = id
        self.title = title
        self.achievementDescription = achievementDescription
        self.iconName = iconName
        self.isUnlocked = isUnlocked
        self.unlockedAt = unlockedAt
        self.requiredPoints = requiredPoints
    }
}
