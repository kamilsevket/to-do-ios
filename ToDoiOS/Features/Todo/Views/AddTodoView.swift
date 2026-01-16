import SwiftUI
import SwiftData

struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var priority: TodoItem.Priority = .medium
    @State private var dueDate = Date()
    @State private var hasDueDate = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Task Details") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Priority") {
                    Picker("Priority", selection: $priority) {
                        ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Text(priority.rawValue)
                                Text("+\(priority.points) pts")
                                    .foregroundColor(.secondary)
                            }
                            .tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Due Date") {
                    Toggle("Set due date", isOn: $hasDueDate)
                    if hasDueDate {
                        DatePicker("Due", selection: $dueDate, displayedComponents: .date)
                    }
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { saveTodo() }
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func saveTodo() {
        let todo = TodoItem(
            title: title,
            itemDescription: description,
            priority: priority,
            dueDate: hasDueDate ? dueDate : nil
        )
        modelContext.insert(todo)
        dismiss()
    }
}

#Preview {
    AddTodoView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
