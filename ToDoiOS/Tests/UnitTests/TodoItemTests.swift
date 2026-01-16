import XCTest
@testable import ToDoiOS

final class TodoItemTests: XCTestCase {

    func testTodoItemCreation() {
        let todo = TodoItem(title: "Test Task", priority: .high)

        XCTAssertEqual(todo.title, "Test Task")
        XCTAssertEqual(todo.priority, .high)
        XCTAssertFalse(todo.isCompleted)
        XCTAssertNil(todo.completedAt)
        XCTAssertEqual(todo.pointsAwarded, 0)
    }

    func testTodoItemCreationWithDefaultPriority() {
        let todo = TodoItem(title: "Default Priority Task")

        XCTAssertEqual(todo.title, "Default Priority Task")
        XCTAssertEqual(todo.priority, .medium)
        XCTAssertFalse(todo.isCompleted)
        XCTAssertEqual(todo.itemDescription, "")
        XCTAssertNil(todo.dueDate)
    }

    func testTodoItemCreationWithDescription() {
        let todo = TodoItem(title: "Task with Description", itemDescription: "This is a description")

        XCTAssertEqual(todo.title, "Task with Description")
        XCTAssertEqual(todo.itemDescription, "This is a description")
    }

    func testTodoItemCreationWithDueDate() {
        let dueDate = Date()
        let todo = TodoItem(title: "Task with Due Date", dueDate: dueDate)

        XCTAssertEqual(todo.title, "Task with Due Date")
        XCTAssertEqual(todo.dueDate, dueDate)
    }

    func testTodoItemCompletion() {
        let todo = TodoItem(title: "Test Task", priority: .high)

        todo.complete()

        XCTAssertTrue(todo.isCompleted)
        XCTAssertNotNil(todo.completedAt)
        XCTAssertEqual(todo.pointsAwarded, 50)
    }

    func testTodoItemCompletionLowPriority() {
        let todo = TodoItem(title: "Low Priority Task", priority: .low)

        todo.complete()

        XCTAssertTrue(todo.isCompleted)
        XCTAssertEqual(todo.pointsAwarded, 10)
    }

    func testTodoItemCompletionMediumPriority() {
        let todo = TodoItem(title: "Medium Priority Task", priority: .medium)

        todo.complete()

        XCTAssertTrue(todo.isCompleted)
        XCTAssertEqual(todo.pointsAwarded, 25)
    }

    func testPriorityPoints() {
        XCTAssertEqual(TodoItem.Priority.low.points, 10)
        XCTAssertEqual(TodoItem.Priority.medium.points, 25)
        XCTAssertEqual(TodoItem.Priority.high.points, 50)
    }

    func testPriorityColors() {
        XCTAssertEqual(TodoItem.Priority.low.color, "PriorityLow")
        XCTAssertEqual(TodoItem.Priority.medium.color, "PriorityMedium")
        XCTAssertEqual(TodoItem.Priority.high.color, "PriorityHigh")
    }

    func testTodoItemHasUniqueId() {
        let todo1 = TodoItem(title: "Task 1")
        let todo2 = TodoItem(title: "Task 2")

        XCTAssertNotEqual(todo1.id, todo2.id)
    }

    func testTodoItemCreatedAtIsSet() {
        let beforeCreation = Date()
        let todo = TodoItem(title: "Test Task")
        let afterCreation = Date()

        XCTAssertGreaterThanOrEqual(todo.createdAt, beforeCreation)
        XCTAssertLessThanOrEqual(todo.createdAt, afterCreation)
    }
}
