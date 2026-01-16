import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TodoItem.createdAt, order: .reverse) private var todos: [TodoItem]
    @State private var showingAddSheet = false
    @State private var viewModel = TodoViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                if todos.isEmpty {
                    emptyStateView
                } else {
                    todoListContent
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTodoView()
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "checklist")
                .font(.system(size: 64))
                .foregroundColor(.secondary)
            Text("No tasks yet")
                .font(.title2.bold())
            Text("Tap + to add your first task")
                .foregroundColor(.secondary)
        }
    }

    private var todoListContent: some View {
        List {
            ForEach(todos) { todo in
                TodoRowView(
                    todo: todo,
                    onComplete: {
                        viewModel.completeTodo(todo, context: modelContext)
                    }
                )
            }
            .onDelete(perform: deleteTodos)
        }
        .listStyle(.plain)
    }

    private func deleteTodos(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
        }
    }
}

#Preview {
    TodoListView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
