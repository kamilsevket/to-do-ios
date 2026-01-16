import XCTest
@testable import ToDoiOS

final class ProfileViewModelTests: XCTestCase {

    private func makeViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }

    func testCompletionRateEmpty() {
        let viewModel = makeViewModel()
        let rate = viewModel.getCompletionRate(todos: [])
        XCTAssertEqual(rate, 0)
    }

    func testCompletionRateHalf() {
        let viewModel = makeViewModel()
        let todo1 = TodoItem(title: "Task 1")
        todo1.complete()
        let todo2 = TodoItem(title: "Task 2")

        let rate = viewModel.getCompletionRate(todos: [todo1, todo2])
        XCTAssertEqual(rate, 0.5, accuracy: 0.001)
    }

    func testCompletionRateFull() {
        let viewModel = makeViewModel()
        let todo1 = TodoItem(title: "Task 1")
        todo1.complete()
        let todo2 = TodoItem(title: "Task 2")
        todo2.complete()

        let rate = viewModel.getCompletionRate(todos: [todo1, todo2])
        XCTAssertEqual(rate, 1.0, accuracy: 0.001)
    }

    func testCompletionRateNone() {
        let viewModel = makeViewModel()
        let todo1 = TodoItem(title: "Task 1")
        let todo2 = TodoItem(title: "Task 2")

        let rate = viewModel.getCompletionRate(todos: [todo1, todo2])
        XCTAssertEqual(rate, 0.0, accuracy: 0.001)
    }

    func testCompletionRateSingleCompleted() {
        let viewModel = makeViewModel()
        let todo = TodoItem(title: "Single Task")
        todo.complete()

        let rate = viewModel.getCompletionRate(todos: [todo])
        XCTAssertEqual(rate, 1.0, accuracy: 0.001)
    }

    func testCompletionRateSingleNotCompleted() {
        let viewModel = makeViewModel()
        let todo = TodoItem(title: "Single Task")

        let rate = viewModel.getCompletionRate(todos: [todo])
        XCTAssertEqual(rate, 0.0, accuracy: 0.001)
    }

    func testCompletionRateMultipleTasks() {
        let viewModel = makeViewModel()
        let todos = (1...10).map { TodoItem(title: "Task \($0)") }

        todos[0].complete()
        todos[2].complete()
        todos[4].complete()

        let rate = viewModel.getCompletionRate(todos: todos)
        XCTAssertEqual(rate, 0.3, accuracy: 0.001)
    }

    func testCompletionRateQuarter() {
        let viewModel = makeViewModel()
        let todos = (1...4).map { TodoItem(title: "Task \($0)") }
        todos[0].complete()

        let rate = viewModel.getCompletionRate(todos: todos)
        XCTAssertEqual(rate, 0.25, accuracy: 0.001)
    }

    func testCompletionRateThreeQuarters() {
        let viewModel = makeViewModel()
        let todos = (1...4).map { TodoItem(title: "Task \($0)") }
        todos[0].complete()
        todos[1].complete()
        todos[2].complete()

        let rate = viewModel.getCompletionRate(todos: todos)
        XCTAssertEqual(rate, 0.75, accuracy: 0.001)
    }
}
