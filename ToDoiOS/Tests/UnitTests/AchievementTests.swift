import XCTest
@testable import ToDoiOS

final class AchievementTests: XCTestCase {

    func testAchievementCreation() {
        let achievement = Achievement(type: .firstTask)

        XCTAssertEqual(achievement.type, .firstTask)
        XCTAssertFalse(achievement.isUnlocked)
        XCTAssertNil(achievement.unlockedAt)
        XCTAssertEqual(achievement.progress, 0)
    }

    func testAchievementUnlock() {
        let achievement = Achievement(type: .firstTask)

        achievement.updateProgress(1)

        XCTAssertTrue(achievement.isUnlocked)
        XCTAssertNotNil(achievement.unlockedAt)
        XCTAssertEqual(achievement.progress, 1)
    }

    func testAchievementProgressNotUnlocked() {
        let achievement = Achievement(type: .tenTasks)

        achievement.updateProgress(5)

        XCTAssertFalse(achievement.isUnlocked)
        XCTAssertEqual(achievement.progress, 5)
    }

    func testAchievementProgressExceedsTarget() {
        let achievement = Achievement(type: .firstTask)

        achievement.updateProgress(5)

        XCTAssertTrue(achievement.isUnlocked)
        XCTAssertEqual(achievement.progress, 5)
    }

    func testAchievementTypes() {
        XCTAssertEqual(Achievement.AchievementType.firstTask.target, 1)
        XCTAssertEqual(Achievement.AchievementType.tenTasks.target, 10)
        XCTAssertEqual(Achievement.AchievementType.weekStreak.target, 7)
        XCTAssertEqual(Achievement.AchievementType.levelFive.target, 5)
    }

    func testAllAchievementTargets() {
        XCTAssertEqual(Achievement.AchievementType.firstTask.target, 1)
        XCTAssertEqual(Achievement.AchievementType.tenTasks.target, 10)
        XCTAssertEqual(Achievement.AchievementType.fiftyTasks.target, 50)
        XCTAssertEqual(Achievement.AchievementType.hundredTasks.target, 100)
        XCTAssertEqual(Achievement.AchievementType.weekStreak.target, 7)
        XCTAssertEqual(Achievement.AchievementType.monthStreak.target, 30)
        XCTAssertEqual(Achievement.AchievementType.levelFive.target, 5)
        XCTAssertEqual(Achievement.AchievementType.levelTen.target, 10)
    }

    func testAchievementTypeTitles() {
        XCTAssertEqual(Achievement.AchievementType.firstTask.title, "First Steps")
        XCTAssertEqual(Achievement.AchievementType.tenTasks.title, "Getting Started")
        XCTAssertEqual(Achievement.AchievementType.fiftyTasks.title, "Task Master")
        XCTAssertEqual(Achievement.AchievementType.hundredTasks.title, "Centurion")
        XCTAssertEqual(Achievement.AchievementType.weekStreak.title, "Week Warrior")
        XCTAssertEqual(Achievement.AchievementType.monthStreak.title, "Monthly Champion")
        XCTAssertEqual(Achievement.AchievementType.levelFive.title, "Rising Star")
        XCTAssertEqual(Achievement.AchievementType.levelTen.title, "Expert")
    }

    func testAchievementTypeDescriptions() {
        XCTAssertEqual(Achievement.AchievementType.firstTask.description, "Complete your first task")
        XCTAssertEqual(Achievement.AchievementType.tenTasks.description, "Complete 10 tasks")
        XCTAssertEqual(Achievement.AchievementType.fiftyTasks.description, "Complete 50 tasks")
        XCTAssertEqual(Achievement.AchievementType.hundredTasks.description, "Complete 100 tasks")
        XCTAssertEqual(Achievement.AchievementType.weekStreak.description, "Maintain a 7-day streak")
        XCTAssertEqual(Achievement.AchievementType.monthStreak.description, "Maintain a 30-day streak")
        XCTAssertEqual(Achievement.AchievementType.levelFive.description, "Reach level 5")
        XCTAssertEqual(Achievement.AchievementType.levelTen.description, "Reach level 10")
    }

    func testAchievementTypeIcons() {
        XCTAssertEqual(Achievement.AchievementType.firstTask.icon, "star.fill")
        XCTAssertEqual(Achievement.AchievementType.tenTasks.icon, "flame.fill")
        XCTAssertEqual(Achievement.AchievementType.fiftyTasks.icon, "trophy.fill")
        XCTAssertEqual(Achievement.AchievementType.hundredTasks.icon, "crown.fill")
        XCTAssertEqual(Achievement.AchievementType.weekStreak.icon, "calendar")
        XCTAssertEqual(Achievement.AchievementType.monthStreak.icon, "calendar.badge.checkmark")
        XCTAssertEqual(Achievement.AchievementType.levelFive.icon, "arrow.up.circle.fill")
        XCTAssertEqual(Achievement.AchievementType.levelTen.icon, "sparkles")
    }

    func testAchievementHasUniqueId() {
        let achievement1 = Achievement(type: .firstTask)
        let achievement2 = Achievement(type: .firstTask)

        XCTAssertNotEqual(achievement1.id, achievement2.id)
    }

    func testAchievementUnlockOnlyOnce() {
        let achievement = Achievement(type: .firstTask)

        achievement.updateProgress(1)
        let firstUnlockTime = achievement.unlockedAt

        achievement.updateProgress(2)

        XCTAssertEqual(achievement.unlockedAt, firstUnlockTime)
        XCTAssertEqual(achievement.progress, 2)
    }

    func testAchievementTypeAllCases() {
        let allTypes = Achievement.AchievementType.allCases

        XCTAssertEqual(allTypes.count, 8)
        XCTAssertTrue(allTypes.contains(.firstTask))
        XCTAssertTrue(allTypes.contains(.tenTasks))
        XCTAssertTrue(allTypes.contains(.fiftyTasks))
        XCTAssertTrue(allTypes.contains(.hundredTasks))
        XCTAssertTrue(allTypes.contains(.weekStreak))
        XCTAssertTrue(allTypes.contains(.monthStreak))
        XCTAssertTrue(allTypes.contains(.levelFive))
        XCTAssertTrue(allTypes.contains(.levelTen))
    }

    func testTenTasksAchievementUnlock() {
        let achievement = Achievement(type: .tenTasks)

        achievement.updateProgress(10)

        XCTAssertTrue(achievement.isUnlocked)
        XCTAssertNotNil(achievement.unlockedAt)
    }

    func testWeekStreakAchievementUnlock() {
        let achievement = Achievement(type: .weekStreak)

        achievement.updateProgress(7)

        XCTAssertTrue(achievement.isUnlocked)
        XCTAssertNotNil(achievement.unlockedAt)
    }

    func testLevelFiveAchievementUnlock() {
        let achievement = Achievement(type: .levelFive)

        achievement.updateProgress(5)

        XCTAssertTrue(achievement.isUnlocked)
        XCTAssertNotNil(achievement.unlockedAt)
    }
}
