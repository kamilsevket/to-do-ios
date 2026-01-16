import XCTest
@testable import ToDoiOS

final class ProfileViewModelTests: XCTestCase {

    var viewModel: ProfileViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ProfileViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testCompletionRateEmpty() {
        let rate = viewModel.getCompletionRate(todos: [])
        XCTAssertEqual(rate, 0)
    }

    func testCompletionRateHalf() {
        let todo1 = TodoItem(title: "Task 1")
        todo1.complete()
        let todo2 = TodoItem(title: "Task 2")

        let rate = viewModel.getCompletionRate(todos: [todo1, todo2])
        XCTAssertEqual(rate, 0.5, accuracy: 0.001)
    }

    func testCompletionRateFull() {
        let todo1 = TodoItem(title: "Task 1")
        todo1.complete()
        let todo2 = TodoItem(title: "Task 2")
        todo2.complete()

        let rate = viewModel.getCompletionRate(todos: [todo1, todo2])
        XCTAssertEqual(rate, 1.0, accuracy: 0.001)
    }

    func testCompletionRateNone() {
        let todo1 = TodoItem(title: "Task 1")
        let todo2 = TodoItem(title: "Task 2")

        let rate = viewModel.getCompletionRate(todos: [todo1, todo2])
        XCTAssertEqual(rate, 0.0, accuracy: 0.001)
    }

    func testCompletionRateSingleCompleted() {
        let todo = TodoItem(title: "Single Task")
        todo.complete()

        let rate = viewModel.getCompletionRate(todos: [todo])
        XCTAssertEqual(rate, 1.0, accuracy: 0.001)
    }

    func testCompletionRateSingleNotCompleted() {
        let todo = TodoItem(title: "Single Task")

        let rate = viewModel.getCompletionRate(todos: [todo])
        XCTAssertEqual(rate, 0.0, accuracy: 0.001)
    }

    func testCompletionRateMultipleTasks() {
        let todos = (1...10).map { TodoItem(title: "Task \($0)") }

        todos[0].complete()
        todos[2].complete()
        todos[4].complete()

        let rate = viewModel.getCompletionRate(todos: todos)
        XCTAssertEqual(rate, 0.3, accuracy: 0.001)
    }

    func testCompletionRateQuarter() {
        let todos = (1...4).map { TodoItem(title: "Task \($0)") }
        todos[0].complete()

        let rate = viewModel.getCompletionRate(todos: todos)
        XCTAssertEqual(rate, 0.25, accuracy: 0.001)
    }

    func testCompletionRateThreeQuarters() {
        let todos = (1...4).map { TodoItem(title: "Task \($0)") }
        todos[0].complete()
        todos[1].complete()
        todos[2].complete()

        let rate = viewModel.getCompletionRate(todos: todos)
        XCTAssertEqual(rate, 0.75, accuracy: 0.001)
    }
}
