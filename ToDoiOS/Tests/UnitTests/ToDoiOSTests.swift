import XCTest
@testable import ToDoiOS

final class ToDoiOSTests: XCTestCase {
    func testTodoItemCreation() {
        let item = TodoItem(title: "Test Task")
        XCTAssertEqual(item.title, "Test Task")
        XCTAssertFalse(item.isCompleted)
        XCTAssertEqual(item.priority, .medium)
        XCTAssertEqual(item.points, 10)
    }

    func testUserProfileCreation() {
        let profile = UserProfile(name: "Test User")
        XCTAssertEqual(profile.name, "Test User")
        XCTAssertEqual(profile.totalPoints, 0)
        XCTAssertEqual(profile.level, 1)
    }

    func testAchievementCreation() {
        let achievement = Achievement(
            title: "First Task",
            achievementDescription: "Complete your first task",
            iconName: "star.fill"
        )
        XCTAssertEqual(achievement.title, "First Task")
        XCTAssertFalse(achievement.isUnlocked)
    }
}
