import XCTest
@testable import ToDoiOS

final class UserProfileTests: XCTestCase {

    func testProfileInitialization() {
        let profile = UserProfile()

        XCTAssertEqual(profile.totalPoints, 0)
        XCTAssertEqual(profile.level, 1)
        XCTAssertEqual(profile.tasksCompleted, 0)
        XCTAssertEqual(profile.currentStreak, 0)
        XCTAssertEqual(profile.longestStreak, 0)
        XCTAssertNil(profile.lastCompletionDate)
    }

    func testAddPoints() {
        let profile = UserProfile()

        profile.addPoints(50)

        XCTAssertEqual(profile.totalPoints, 50)
        XCTAssertEqual(profile.tasksCompleted, 1)
        XCTAssertEqual(profile.currentStreak, 1)
    }

    func testAddPointsMultipleTimes() {
        let profile = UserProfile()

        profile.addPoints(25)
        profile.addPoints(25)

        XCTAssertEqual(profile.totalPoints, 50)
        XCTAssertEqual(profile.tasksCompleted, 2)
    }

    func testLevelUp() {
        let profile = UserProfile()

        profile.addPoints(100)

        XCTAssertEqual(profile.level, 2)
    }

    func testMultipleLevelUps() {
        let profile = UserProfile()

        profile.addPoints(250)

        XCTAssertEqual(profile.level, 3)
    }

    func testLevelUpAtExactBoundary() {
        let profile = UserProfile()

        profile.addPoints(100)
        XCTAssertEqual(profile.level, 2)

        profile.addPoints(100)
        XCTAssertEqual(profile.level, 3)
    }

    func testProgressToNextLevel() {
        let profile = UserProfile()
        profile.addPoints(50)

        XCTAssertEqual(profile.progressToNextLevel, 0.5, accuracy: 0.001)
    }

    func testProgressToNextLevelAtZero() {
        let profile = UserProfile()

        XCTAssertEqual(profile.progressToNextLevel, 0.0, accuracy: 0.001)
    }

    func testProgressToNextLevelAfterLevelUp() {
        let profile = UserProfile()
        profile.addPoints(150)

        XCTAssertEqual(profile.level, 2)
        XCTAssertEqual(profile.progressToNextLevel, 0.25, accuracy: 0.001)
    }

    func testPointsForNextLevel() {
        let profile = UserProfile()

        XCTAssertEqual(profile.pointsForNextLevel, 100)

        profile.addPoints(100)
        XCTAssertEqual(profile.pointsForNextLevel, 200)

        profile.addPoints(200)
        XCTAssertEqual(profile.pointsForNextLevel, 300)
    }

    func testStreakInitialization() {
        let profile = UserProfile()
        profile.addPoints(10)

        XCTAssertEqual(profile.currentStreak, 1)
        XCTAssertEqual(profile.longestStreak, 1)
        XCTAssertNotNil(profile.lastCompletionDate)
    }

    func testLongestStreakTracking() {
        let profile = UserProfile()

        profile.addPoints(10)
        profile.addPoints(10)

        XCTAssertEqual(profile.currentStreak, 1)
        XCTAssertGreaterThanOrEqual(profile.longestStreak, 1)
    }

    func testProfileHasUniqueId() {
        let profile1 = UserProfile()
        let profile2 = UserProfile()

        XCTAssertNotEqual(profile1.id, profile2.id)
    }

    func testProfileCreatedAtIsSet() {
        let beforeCreation = Date()
        let profile = UserProfile()
        let afterCreation = Date()

        XCTAssertGreaterThanOrEqual(profile.createdAt, beforeCreation)
        XCTAssertLessThanOrEqual(profile.createdAt, afterCreation)
    }

    func testLastCompletionDateIsUpdated() {
        let profile = UserProfile()
        let beforeCompletion = Date()

        profile.addPoints(10)

        let afterCompletion = Date()

        XCTAssertNotNil(profile.lastCompletionDate)
        XCTAssertGreaterThanOrEqual(profile.lastCompletionDate!, beforeCompletion)
        XCTAssertLessThanOrEqual(profile.lastCompletionDate!, afterCompletion)
    }
}
