import XCTest
@testable import ToDoiOS

final class ToDoiOSTests: XCTestCase {
    func testTodoItemCreation() {
        let item = TodoItem(title: "Test Task")
        XCTAssertEqual(item.title, "Test Task")
        XCTAssertFalse(item.isCompleted)
        XCTAssertEqual(item.priority, .medium)
        XCTAssertEqual(item.pointsAwarded, 0)
    }

    func testTodoItemCompletion() {
        let item = TodoItem(title: "Test Task", priority: .high)
        item.complete()
        XCTAssertTrue(item.isCompleted)
        XCTAssertEqual(item.pointsAwarded, 50)
        XCTAssertNotNil(item.completedAt)
    }

    func testUserProfileCreation() {
        let profile = UserProfile()
        XCTAssertEqual(profile.totalPoints, 0)
        XCTAssertEqual(profile.level, 1)
        XCTAssertEqual(profile.tasksCompleted, 0)
    }

    func testUserProfileAddPoints() {
        let profile = UserProfile()
        profile.addPoints(25)
        XCTAssertEqual(profile.totalPoints, 25)
        XCTAssertEqual(profile.tasksCompleted, 1)
        XCTAssertEqual(profile.currentStreak, 1)
    }

    func testAchievementCreation() {
        let achievement = Achievement(type: .firstTask)
        XCTAssertEqual(achievement.type.title, "First Steps")
        XCTAssertFalse(achievement.isUnlocked)
        XCTAssertEqual(achievement.progress, 0)
    }

    func testAchievementUnlock() {
        let achievement = Achievement(type: .firstTask)
        achievement.updateProgress(1)
        XCTAssertTrue(achievement.isUnlocked)
        XCTAssertNotNil(achievement.unlockedAt)
    }
}
